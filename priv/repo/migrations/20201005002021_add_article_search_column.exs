defmodule Kudzu.Repo.Migrations.AddArticleSearchColumn do
  use Ecto.Migration

  def up do
    execute """
      alter table articles
        add column search_tsv tsvector
          generated always as (
            setweight(to_tsvector('simple', coalesce(title, '')), 'A') || ' ' ||
            setweight(to_tsvector('simple', coalesce(description, '')), 'B')
          ) stored;
    """
  end

  def down do
    execute "alter table articles drop column search_tsv;"
  end
end
