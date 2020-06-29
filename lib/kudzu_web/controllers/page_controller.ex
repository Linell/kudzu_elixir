defmodule KudzuWeb.PageController do
  use KudzuWeb, :controller

  def index(conn, _params) do
    conn
    |> render("index.html")
  end
end
