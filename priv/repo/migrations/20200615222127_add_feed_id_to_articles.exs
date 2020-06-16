defmodule Kudzu.Repo.Migrations.AddFeedIdToArticles do
  use Ecto.Migration

  def change do
    alter table(:articles) do
      add    :feed_id, references(:feeds)
      remove :source,  :string
    end
  end
end
