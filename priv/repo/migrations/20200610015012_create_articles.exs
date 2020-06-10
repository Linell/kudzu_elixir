defmodule Kudzu.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :url,            :string
      add :title,          :string
      add :description,    :text
      add :published_date, :naive_datetime
      add :source,         :string

      timestamps()
    end

  end
end
