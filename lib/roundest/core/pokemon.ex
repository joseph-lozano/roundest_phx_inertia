defmodule Roundest.Core.Pokemon do
  alias Roundest.Core.Vote
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "pokemon" do
    field :pokemon_id, :integer
    field :name, :string

    has_many :won_votes, Vote, foreign_key: :winner_id
    has_many :lost_votes, Vote, foreign_key: :loser_id
  end
end

defimpl Jason.Encoder, for: Roundest.Core.Pokemon do
  alias Roundest.Core.Pokemon

  def encode(%Pokemon{id: id, pokemon_id: pokemon_id, name: name}, options) do
    %{
      id: id,
      pokemonId: pokemon_id,
      name: name
    }
    |> Jason.Encode.map(options)
  end
end
