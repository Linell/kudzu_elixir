defmodule KudzuWeb.ArticleController do
  use KudzuWeb, :controller

  def index(conn, _params) do
    conn
    |> Plug.Conn.assign(:latest_articles, Kudzu.Articles.list_latest_articles())
    |> render("index.html")
  end

  def show(conn, %{"id" => id}) do
    article = Kudzu.Articles.get_article!(id)

    render(conn, "show.html", article: article)
  end
end
