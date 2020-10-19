defmodule KudzuWeb.ArticleExploreLive do
  use   Phoenix.LiveView
  alias KudzuWeb.Credentials

  # XXX: all of this should absolutely be refactored into the Articles context
  import Ecto.Query, warn: false
  alias Kudzu.Repo
  alias Kudzu.Articles.Article

  def render(assigns) do
    KudzuWeb.ArticleView.render("explore_live.html", assigns)
  end

  def mount(_params, session, socket) do
    current_user = Credentials.get_user(socket, session)

    articles = Article
               |> order_by([desc: :published_date, desc: :updated_at])
               |> preload([:feed, :tags])
               |> Repo.all
    # |> where("search_tsv @@ to_tsquery('?')", 

    socket = assign(socket, articles: articles, search_text: nil)

    { :ok, socket }
  end

  def handle_event("search_form_update", session, socket) do
    articles = Article
               |> order_by([desc: :published_date, desc: :updated_at])
               |> preload([:feed, :tags])
               |> Repo.all

    socket = assign(socket, articles: articles)

    { :noreply, socket }
  end
end
