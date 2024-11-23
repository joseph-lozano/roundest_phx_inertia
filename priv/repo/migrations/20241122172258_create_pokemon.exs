defmodule Roundest.Repo.Migrations.CreatePokemon do
  use Ecto.Migration

  def change do
    create table(:pokemon, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :pokemon_id, :integer
      add :name, :string
    end

    create unique_index(:pokemon, [:pokemon_id])
  end
end
