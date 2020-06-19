defmodule Kudzu.Repo.Migrations.AddFeedIdToArticles do
  use Ecto.Migration

  def change do
    alter table(:articles) do
      add    :feed_id, references(:feeds, on_delete: :delete_all)
      remove :source,  :string
    end
  end
end
