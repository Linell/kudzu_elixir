defmodule Kudzu.Topics.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field :description,      :string
    field :preferred_tag_id, :integer
    field :title,            :string
    embeds_many :matches, Kudzu.Topics.Match, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(topic, attrs) do
    topic
    |> cast(attrs, [:title, :description, :preferred_tag_id])
    |> cast_embed(:matches)
    |> validate_required([:title, :preferred_tag_id])
  end
end

# TODO:
# I'm right in the middle of trying to add topics. I just noticed that the admin layout is messed up so I 
# definitely need to fix that. after that I want to work on the ability to set various phrases that 
# I can then look for in a newly imported article. I want to put those into that matches
# piece of this sucker. I'm thinking like "Trump"< "Donald J Trump", etc. That way I can
# have a set of words that will all map to the predefined ticket.
#
