defmodule Roundest.Repo.Migrations.InsertPokemonSchema do
  use Ecto.Schema

  @primary_key false
  @primary_key {:id, :binary_id, autogenerate: true}
  schema "pokemon" do
    field(:pokemon_id, :integer)
    field(:name, :string)
  end
end

defmodule Roundest.Repo.Migrations.InsertPokemon do
  use Ecto.Migration
  import Ecto.Query

  @disable_ddl_transaction true
  @disable_migration_lock true

  def up do
    data =
      :code.priv_dir(:roundest)
      |> Path.join("/data.jsonl")
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Enum.map(&Jason.decode!(&1, keys: :atoms))
      |> then(
        &repo().insert_all(Roundest.Repo.Migrations.InsertPokemonSchema, &1,
          on_conflict: :nothing,
          conflict_target: [:pokemon_id]
        )
      )
  end
end
