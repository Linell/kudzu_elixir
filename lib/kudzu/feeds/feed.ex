defmodule Kudzu.Feeds.Feed do
  use Ecto.Schema
  import Ecto.Changeset

  schema "feeds" do
    field :description, :string
    field :logo_url, :string
    field :slug, :string
    field :title, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(feed, attrs) do
    feed
    |> cast(attrs, [:url, :title, :description, :slug, :logo_url])
    |> validate_required([:url, :title, :description, :slug, :logo_url])
  end
end
