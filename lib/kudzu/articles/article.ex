defmodule Kudzu.Articles.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :title,          :string
    field :description,    :string
    field :url,            :string
    field :published_date, :naive_datetime

    belongs_to :feed, Kudzu.Feeds.Feed

    has_many :user_article_tags, Kudzu.UserArticleTags.UserArticleTag
    has_many :tags, through: [:user_article_tags, :tag]

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:url, :title, :description, :published_date, :feed_id])
    |> validate_required([:url, :title, :published_date])
  end
end
