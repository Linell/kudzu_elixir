defmodule Kudzu.Repo.Migrations.AddPgTrgm do
  use Ecto.Migration

  def up do
    execute "CREATE extension if not exists pg_trgm;"
    execute "CREATE INDEX tags_tag_trgm_index ON tags USING gin (tag gin_trgm_ops);"
  end

  def down do
    execute "DROP INDEX tags_tag_trgm_index;"
  end
end
