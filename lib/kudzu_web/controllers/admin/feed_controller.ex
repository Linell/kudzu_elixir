defmodule KudzuWeb.Admin.FeedController do
  use KudzuWeb, :controller

  alias Kudzu.Feeds
  alias Kudzu.Feeds.Feed

  
  plug(:put_layout, {KudzuWeb.LayoutView, "torch.html"})
  

  def index(conn, params) do
    case Feeds.paginate_feeds(params) do
      {:ok, assigns} ->
        render(conn, "index.html", assigns)
      error ->
        conn
        |> put_flash(:error, "There was an error rendering Feeds. #{inspect(error)}")
        |> redirect(to: Routes.admin_feed_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = Feeds.change_feed(%Feed{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"feed" => feed_params}) do
    case Feeds.create_feed(feed_params) do
      {:ok, feed} ->
        conn
        |> put_flash(:info, "Feed created successfully.")
        |> redirect(to: Routes.admin_feed_path(conn, :show, feed))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    feed = Feeds.get_feed!(id)
    render(conn, "show.html", feed: feed)
  end

  def edit(conn, %{"id" => id}) do
    feed = Feeds.get_feed!(id)
    changeset = Feeds.change_feed(feed)
    render(conn, "edit.html", feed: feed, changeset: changeset)
  end

  def update(conn, %{"id" => id, "feed" => feed_params}) do
    feed = Feeds.get_feed!(id)

    case Feeds.update_feed(feed, feed_params) do
      {:ok, feed} ->
        conn
        |> put_flash(:info, "Feed updated successfully.")
        |> redirect(to: Routes.admin_feed_path(conn, :show, feed))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", feed: feed, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    feed = Feeds.get_feed!(id)
    {:ok, _feed} = Feeds.delete_feed(feed)

    conn
    |> put_flash(:info, "Feed deleted successfully.")
    |> redirect(to: Routes.admin_feed_path(conn, :index))
  end
end
