defmodule Kudzu.Topics.Match do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :phrase, :string
  end

  def string_to_match_list(string) do
    string
    |> String.split(",")
    |> Enum.map(fn s -> String.trim(s) end)
    |> Enum.map(fn s -> %{phrase: s} end)
  end

  def match_list_to_string(match_list) do
    match_list
    |> Enum.map(fn m -> m.phrase end)
    |> Enum.join(", ")
  end

  @doc false
  def changeset(match, attrs) do
    match
    |> cast(attrs, [:phrase])
  end
end
