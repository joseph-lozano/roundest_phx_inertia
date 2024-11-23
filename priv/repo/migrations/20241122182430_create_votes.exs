defmodule Roundest.Repo.Migrations.CreateVotes do
  use Ecto.Migration

  def change do
    create table(:votes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :winner_id, references(:pokemon, on_delete: :nothing, type: :binary_id)
      add :loser_id, references(:pokemon, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:votes, [:winner_id])
    create index(:votes, [:loser_id])
  end
end
