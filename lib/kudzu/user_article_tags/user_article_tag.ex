defmodule Kudzu.UserArticleTags.UserArticleTag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_article_tags" do
    belongs_to :user,    Kudzu.Users.User
    belongs_to :article, Kudzu.Articles.Article
    belongs_to :tag,     Kudzu.Tags.Tag

    timestamps()
  end

  @doc false
  def changeset(user_article_tag, attrs) do
    user_article_tag
    |> cast(attrs, [])
    |> validate_required([])
    |> unique_constraint(:tag_id, name: :index_unique_user_article_tag_combo)
    |> put_assoc(:user,    attrs.user    || user_article_tag.user)
    |> put_assoc(:article, attrs.article || user_article_tag.article)
    |> put_assoc(:tag,     attrs.tag     || user_article_tag.tag)
  end
end
