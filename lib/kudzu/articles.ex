defmodule Kudzu.Articles do
  @moduledoc """
  The Articles context.
  """

  import Ecto.Query, warn: false
  alias Kudzu.Repo

  require IEx

  alias Kudzu.Articles.Article
  alias Kudzu.Tags.Tag
  alias Kudzu.UserArticleTags.UserArticleTag
  alias Kudzu.Feeds.Feed

  @doc """
  Returns the 25 latest articles
  """
  def list_latest_articles(%{"tags" => tags}) do
    processed_tag_ids = Enum.map(tags, fn(t) ->
      tag_from_string = Tag.tag_from_string(t)

      query = from a in Article,
              select: a.id,
              join: uat in UserArticleTag, on: uat.article_id == a.id,
              join: t   in Tag,            on: t.id == uat.tag_id,
              where: t.tag == ^tag_from_string

      Repo.all(query)
    end) |> Enum.reduce(fn tl, acc -> 
      MapSet.intersection(MapSet.new(acc), MapSet.new(tl)) |> MapSet.to_list
    end)

    Article
    |> where([a], a.id in ^processed_tag_ids)
    |> limit(100)
    |> order_by([desc: :published_date, desc: :updated_at])
    |> preload([:feed, :tags])
    |> Repo.all
  end

  def list_latest_articles(_params) do
    Article
    |> preload([:feed, :tags])
    |> order_by([desc: :published_date, desc: :updated_at])
    |> limit(25)
    |> Repo.all
  end

  @doc """
  Returns the list of articles.

  ## Examples

      iex> list_articles()
      [%Article{}, ...]

  """
  def list_articles do
    Repo.all(Article)
  end

  @doc """
  Gets a single article.

  Raises `Ecto.NoResultsError` if the Article does not exist.

  ## Examples

      iex> get_article!(123)
      %Article{}

      iex> get_article!(456)
      ** (Ecto.NoResultsError)

  """
  def get_article!(id), do: Repo.get!(Article, id) |> Repo.preload([:feed, :tags])

  @doc """
  Creates a article.

  ## Examples

      iex> create_article(%{field: value})
      {:ok, %Article{}}

      iex> create_article(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_article(attrs \\ %{}) do
    %Article{}
    |> Article.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates or updates an article
  """
  def create_or_update_article(attrs \\ %{}) do
    query   = from a in Article, where: (a.url == ^attrs.url) or (a.title == ^attrs.title and a.feed_id == ^attrs.feed_id)
    article = Repo.all(query) |> List.first

    if is_nil(article) do
      create_article(attrs)
    else
      update_article(article, attrs)
    end
  end

  @doc """
  Updates a article.

  ## Examples

      iex> update_article(article, %{field: new_value})
      {:ok, %Article{}}

      iex> update_article(article, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_article(%Article{} = article, attrs) do
    article
    |> Article.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a article.

  ## Examples

      iex> delete_article(article)
      {:ok, %Article{}}

      iex> delete_article(article)
      {:error, %Ecto.Changeset{}}

  """
  def delete_article(%Article{} = article) do
    Repo.delete(article)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking article changes.

  ## Examples

      iex> change_article(article)
      %Ecto.Changeset{source: %Article{}}

  """
  def change_article(%Article{} = article) do
    Article.changeset(article, %{})
  end
end
