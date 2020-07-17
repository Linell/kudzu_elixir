defmodule Kudzu.Tags.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tags" do
    field :tag, :string

    has_many :user_article_tags, Kudzu.UserArticleTags.UserArticleTag
    has_many :articles, through: [:user_article_tags, :article]
    has_many :users,    through: [:user_article_tags, :user]

    timestamps()
  end

  def tag_from_string(string) do
    string
    |> String.downcase
    |> maybe_hashtagize
  end

  def maybe_hashtagize(string) do
    cond do
      String.match?(string, ~r/^#/) -> string
      true                          -> "##{string}"
    end
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:tag])
    |> validate_required([:tag])
  end
end
