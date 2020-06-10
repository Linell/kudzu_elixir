defmodule Kudzu.Articles.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :title,          :string
    field :description,    :string
    field :url,            :string
    field :published_date, :naive_datetime
    field :source,         :string

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:url, :title, :description, :published_date, :source])
    |> validate_required([:url, :title, :published_date, :source])
  end
end
