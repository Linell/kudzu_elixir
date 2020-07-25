defmodule Kudzu.Tags do
  @moduledoc """
  The Tags context.
  """

  import Torch.Helpers, only: [sort: 1, paginate: 4]
  import Filtrex.Type.Config
  import Ecto.Query, warn: false
  alias Kudzu.Repo

  alias Kudzu.Tags.Tag

  @pagination [page_size: 15]
  @pagination_distance 5

  @doc """
  Paginate the list of tags using filtrex
  filters.

  ## Examples

      iex> list_tags(%{})
      %{tags: [%Tag{}], ...}
  """
  @spec paginate_tags(map) :: {:ok, map} | {:error, any}
  def paginate_tags(params \\ %{}) do
    params =
      params
      |> Map.put_new("sort_direction", "desc")
      |> Map.put_new("sort_field", "inserted_at")

    {:ok, sort_direction} = Map.fetch(params, "sort_direction")
    {:ok, sort_field} = Map.fetch(params, "sort_field")

    with {:ok, filter} <- Filtrex.parse_params(filter_config(:tags), params["tag"] || %{}),
         %Scrivener.Page{} = page <- do_paginate_tags(filter, params) do
      {:ok,
        %{
          tags: page.entries,
          page_number: page.page_number,
          page_size: page.page_size,
          total_pages: page.total_pages,
          total_entries: page.total_entries,
          distance: @pagination_distance,
          sort_field: sort_field,
          sort_direction: sort_direction
        }
      }
    else
      {:error, error} -> {:error, error}
      error -> {:error, error}
    end
  end

  defp do_paginate_tags(filter, params) do
    Tag
    |> Filtrex.query(filter)
    |> order_by(^sort(params))
    |> paginate(Repo, params, @pagination)
  end

  @doc """
  Returns the list of tags.

  ## Examples

      iex> list_tags()
      [%Tag{}, ...]

  """
  def list_tags do
    Repo.all(Tag)
  end

  @doc """
  Gets a single tag.

  Raises `Ecto.NoResultsError` if the Tag does not exist.

  ## Examples

      iex> get_tag!(123)
      %Tag{}

      iex> get_tag!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tag!(id), do: Repo.get!(Tag, id)

  @doc """
  Creates a tag.

  ## Examples

      iex> create_tag(%{field: value})
      {:ok, %Tag{}}

      iex> create_tag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tag(attrs \\ %{}) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tag.

  ## Examples

      iex> update_tag(tag, %{field: new_value})
      {:ok, %Tag{}}

      iex> update_tag(tag, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tag(%Tag{} = tag, attrs) do
    tag
    |> Tag.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Tag.

  ## Examples

      iex> delete_tag(tag)
      {:ok, %Tag{}}

      iex> delete_tag(tag)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tag(%Tag{} = tag) do
    Repo.delete(tag)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tag changes.

  ## Examples

      iex> change_tag(tag)
      %Ecto.Changeset{source: %Tag{}}

  """
  def change_tag(%Tag{} = tag, attrs \\ %{}) do
    Tag.changeset(tag, attrs)
  end

  @doc """
  Finds or creates a tag.

  This can definitely cause a race condition that won't matter until there are more users
  but 100% needs revisiting.
  """
  def find_or_create_tag(tag_text) do
    processed_text = tag_text |> Tag.tag_from_string

    query = from t in Tag,
            where: t.tag == ^processed_text

    if !Repo.one(query) do
      create_tag(%{tag: processed_text})
    end

    Repo.one(query)
  end

  def search_tags(search_term) do
    processed_text = search_term |> Tag.tag_from_string

    Tag
    |> Tag.search(processed_text)
    |> limit(15)
    |> Repo.all
  end

  defp filter_config(:tags) do
    defconfig do
      number :id
        text :tag
        date :inserted_at
        date :updated_at
        
    end
  end
end
