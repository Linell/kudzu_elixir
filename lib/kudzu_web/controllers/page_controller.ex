defmodule KudzuWeb.PageController do
  use KudzuWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
