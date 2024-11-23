defmodule Roundest.Core do
  alias Roundest.Core.Pokemon
  alias Roundest.Core.Vote
  alias Roundest.Repo
  import Ecto.Query

  def get_two_random_pokemon do
    [a, b] =
      from(p in Pokemon, order_by: fragment("RANDOM()"), limit: 2)
      |> Roundest.Repo.all()

    {a, b}
  end

  def cast_vote(%{"winner_id" => winner_id, "loser_id" => loser_id}) do
    Ecto.Multi.new()
    |> Ecto.Multi.run(:winner, fn repo, _ ->
      case repo.get_by(Pokemon, pokemon_id: winner_id) do
        nil -> {:error, "Pokemon not found"}
        winner -> {:ok, winner}
      end
    end)
    |> Ecto.Multi.run(:loser, fn repo, _ ->
      case repo.get_by(Pokemon, pokemon_id: loser_id) do
        nil -> {:error, "Pokemon not found"}
        loser -> {:ok, loser}
      end
    end)
    |> Ecto.Multi.run(:vote, fn repo, %{winner: winner, loser: loser} ->
      repo.insert(%Vote{winner_id: winner.id, loser_id: loser.id})
    end)
    |> Roundest.Repo.transaction()
    |> tap(fn _ -> Cachex.del(:results_cache, "rankings") end)
    |> tap(fn _ -> Phoenix.PubSub.broadcast(Roundest.PubSub, "results", "update") end)
  end

  def get_rankings do
    Cachex.fetch(:results_cache, "rankings", fn ->
      from(p in Pokemon,
        left_join: w in assoc(p, :won_votes),
        left_join: l in assoc(p, :lost_votes),
        group_by: [p.id, p.pokemon_id, p.name],
        having: count(w.id) + count(l.id) > 0,
        select: %{
          id: p.id,
          pokemonId: p.pokemon_id,
          name: p.name,
          stats: %{
            wins: count(w.id),
            losses: count(l.id),
            winRate: fragment("COUNT(?)::float / (COUNT(?) + COUNT(?))", w.id, w.id, l.id)
          }
        },
        order_by: [
          desc: fragment("COUNT(?)::float / (COUNT(?) + COUNT(?))", w.id, w.id, l.id),
          desc: count(w.id)
        ]
      )
      |> Repo.all()
    end)
    |> then(fn {_, rankings} -> rankings end)
  end
end
