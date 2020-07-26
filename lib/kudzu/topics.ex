defmodule Kudzu.Topics do
  @moduledoc """
  The Topics context.
  """

  import Ecto.Query, warn: false
  alias Kudzu.Repo
import Torch.Helpers, only: [sort: 1, paginate: 4]
import Filtrex.Type.Config

alias Kudzu.Topics.Topic

@pagination [page_size: 15]
@pagination_distance 5

@doc """
Paginate the list of topics using filtrex
filters.

## Examples

    iex> list_topics(%{})
    %{topics: [%Topic{}], ...}
"""
@spec paginate_topics(map) :: {:ok, map} | {:error, any}
def paginate_topics(params \\ %{}) do
  params =
    params
    |> Map.put_new("sort_direction", "desc")
    |> Map.put_new("sort_field", "inserted_at")

  {:ok, sort_direction} = Map.fetch(params, "sort_direction")
  {:ok, sort_field} = Map.fetch(params, "sort_field")

  with {:ok, filter} <- Filtrex.parse_params(filter_config(:topics), params["topic"] || %{}),
       %Scrivener.Page{} = page <- do_paginate_topics(filter, params) do
    {:ok,
      %{
        topics: page.entries,
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

defp do_paginate_topics(filter, params) do
  Topic
  |> Filtrex.query(filter)
  |> order_by(^sort(params))
  |> paginate(Repo, params, @pagination)
end

@doc """
Returns the list of topics.

## Examples

    iex> list_topics()
    [%Topic{}, ...]

"""
def list_topics do
  Repo.all(Topic)
end

@doc """
Gets a single topic.

Raises `Ecto.NoResultsError` if the Topic does not exist.

## Examples

    iex> get_topic!(123)
    %Topic{}

    iex> get_topic!(456)
    ** (Ecto.NoResultsError)

"""
def get_topic!(id), do: Repo.get!(Topic, id)

@doc """
Creates a topic.

## Examples

    iex> create_topic(%{field: value})
    {:ok, %Topic{}}

    iex> create_topic(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

"""
def create_topic(attrs \\ %{}) do
  %Topic{}
  |> Topic.changeset(attrs)
  |> Repo.insert()
end

@doc """
Updates a topic.

## Examples

    iex> update_topic(topic, %{field: new_value})
    {:ok, %Topic{}}

    iex> update_topic(topic, %{field: bad_value})
    {:error, %Ecto.Changeset{}}

"""
def update_topic(%Topic{} = topic, attrs) do
  topic
  |> Topic.changeset(attrs)
  |> Repo.update()
end

@doc """
Deletes a Topic.

## Examples

    iex> delete_topic(topic)
    {:ok, %Topic{}}

    iex> delete_topic(topic)
    {:error, %Ecto.Changeset{}}

"""
def delete_topic(%Topic{} = topic) do
  Repo.delete(topic)
end

@doc """
Returns an `%Ecto.Changeset{}` for tracking topic changes.

## Examples

    iex> change_topic(topic)
    %Ecto.Changeset{source: %Topic{}}

"""
def change_topic(%Topic{} = topic, attrs \\ %{}) do
  Topic.changeset(topic, attrs)
end

defp filter_config(:topics) do
  defconfig do
    text :title
      text :description
      number :preferred_tag_id
       #TODO add config for matches of type map
    
  end
end
end
