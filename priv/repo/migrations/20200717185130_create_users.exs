defmodule Kudzu.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :id, :integer
      add :email, :string
      add :role, :string
      add :inserted_at, :naive_datetime
      add :updated_at, :naive_datetime

      timestamps()
    end

  end
end
