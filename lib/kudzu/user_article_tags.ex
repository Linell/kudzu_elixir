defmodule Kudzu.UserArticleTags do
  @moduledoc """
  The UserArticleTags context.
  """

  import Ecto.Query, warn: false
  alias Kudzu.Repo

  alias Kudzu.UserArticleTags.UserArticleTag

  @doc """
  Returns the list of user_article_tags.

  ## Examples

      iex> list_user_article_tags()
      [%UserArticleTag{}, ...]

  """
  def list_user_article_tags do
    Repo.all(UserArticleTag)
  end

  @doc """
  Gets a single user_article_tag.

  Raises `Ecto.NoResultsError` if the User article tag does not exist.

  ## Examples

      iex> get_user_article_tag!(123)
      %UserArticleTag{}

      iex> get_user_article_tag!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_article_tag!(id), do: Repo.get!(UserArticleTag, id)

  @doc """
  Get how many times users have tagged a given article with a given tag.
  """
  def get_article_tag_count(tag_id, article_id) do
    query = from uat in UserArticleTag,
      where:  uat.article_id == ^article_id and uat.tag_id == ^tag_id,
      select: count(uat.id)

    Repo.one(query)
  end

  @doc """
  Creates a user_article_tag.

  ## Examples

      iex> create_user_article_tag(%{field: value})
      {:ok, %UserArticleTag{}}

      iex> create_user_article_tag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_article_tag(attrs \\ %{}) do
    %UserArticleTag{}
    |> UserArticleTag.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_article_tag.

  ## Examples

      iex> update_user_article_tag(user_article_tag, %{field: new_value})
      {:ok, %UserArticleTag{}}

      iex> update_user_article_tag(user_article_tag, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_article_tag(%UserArticleTag{} = user_article_tag, attrs) do
    user_article_tag
    |> UserArticleTag.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_article_tag.

  ## Examples

      iex> delete_user_article_tag(user_article_tag)
      {:ok, %UserArticleTag{}}

      iex> delete_user_article_tag(user_article_tag)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_article_tag(%UserArticleTag{} = user_article_tag) do
    Repo.delete(user_article_tag)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_article_tag changes.

  ## Examples

      iex> change_user_article_tag(user_article_tag)
      %Ecto.Changeset{source: %UserArticleTag{}}

  """
  def change_user_article_tag(%UserArticleTag{} = user_article_tag) do
    UserArticleTag.changeset(user_article_tag, %{})
  end
end
