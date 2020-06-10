defmodule KudzuWeb.PageController do
  use KudzuWeb, :controller

  def index(conn, _params) do
    conn
    |> Plug.Conn.assign(:latest_articles, Kudzu.Articles.list_latest_articles())
    |> render("index.html")
  end
end
