defmodule Kudzu.Repo.Migrations.CreateUserArticleTags do
  use Ecto.Migration

  def change do
    create table(:user_article_tags) do
      add :user_id,    references(:users,    on_delete: :delete_all)
      add :article_id, references(:articles, on_delete: :delete_all)
      add :tag_id,     references(:tags,     on_delete: :delete_all)

      timestamps()
    end

    create index(:user_article_tags, [:user_id])
    create index(:user_article_tags, [:article_id])
    create index(:user_article_tags, [:tag_id])
  end
end
