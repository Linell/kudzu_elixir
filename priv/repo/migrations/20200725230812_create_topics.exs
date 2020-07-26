defmodule Kudzu.Repo.Migrations.CreateTopics do
  use Ecto.Migration

  def change do
    create table(:topics) do
      add :title,            :string
      add :description,      :string
      add :preferred_tag_id, :integer
      add :matches,          :jsonb, default: "[]"

      timestamps()
    end

  end
end
