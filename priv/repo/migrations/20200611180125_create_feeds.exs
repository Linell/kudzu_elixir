defmodule Kudzu.Repo.Migrations.CreateFeeds do
  use Ecto.Migration

  def change do
    create table(:feeds) do
      add :url,         :string
      add :title,       :string
      add :description, :text
      add :slug,        :string
      add :logo_url,    :string

      timestamps()
    end

  end
end
