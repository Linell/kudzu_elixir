defmodule KudzuWeb.Admin.TopicController do
  use KudzuWeb, :controller

  alias Kudzu.Topics
  alias Kudzu.Topics.Topic

  require IEx
  
  plug(:put_layout, {KudzuWeb.LayoutView, "torch.html"})
  

  def index(conn, params) do
    case Topics.paginate_topics(params) do
      {:ok, assigns} ->
        render(conn, "index.html", assigns)
      error ->
        conn
        |> put_flash(:error, "There was an error rendering Topics. #{inspect(error)}")
        |> redirect(to: Routes.admin_topic_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = Topics.change_topic(%Topic{})
    render(conn, "new.html", changeset: changeset, topic_matches: nil)
  end

  def create(conn, %{"topic" => topic_params}) do
    new_topic_params = Map.merge(topic_params, %{
      "matches" => Kudzu.Topics.Match.string_to_match_list(topic_params["matches_string"])
    })

    case Topics.create_topic(new_topic_params) do
      {:ok, topic} ->
        conn
        |> put_flash(:info, "Topic created successfully.")
        |> redirect(to: Routes.admin_topic_path(conn, :show, topic))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    topic = Topics.get_topic!(id)
    render(conn, "show.html", topic: topic)
  end

  def edit(conn, %{"id" => id}) do
    topic         = Topics.get_topic!(id)
    changeset     = Topics.change_topic(topic)
    topic_matches = Kudzu.Topics.Match.match_list_to_string(topic.matches)

    render(conn, "edit.html", topic: topic, changeset: changeset, topic_matches: topic_matches)
  end

  def update(conn, %{"id" => id, "topic" => topic_params}) do
    topic = Topics.get_topic!(id)

    new_topic_params = Map.merge(topic_params, %{
      "matches" => Kudzu.Topics.Match.string_to_match_list(topic_params["matches_string"])
    })

    case Topics.update_topic(topic, new_topic_params) do
      {:ok, topic} ->
        conn
        |> put_flash(:info, "Topic updated successfully.")
        |> redirect(to: Routes.admin_topic_path(conn, :show, topic))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", topic: topic, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    topic = Topics.get_topic!(id)
    {:ok, _topic} = Topics.delete_topic(topic)

    conn
    |> put_flash(:info, "Topic deleted successfully.")
    |> redirect(to: Routes.admin_topic_path(conn, :index))
  end
end
