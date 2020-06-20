defmodule Kudzu.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :tag, :string

      timestamps()
    end

  end
end
