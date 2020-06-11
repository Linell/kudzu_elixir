defmodule KudzuWeb.PageControllerTest do
  use KudzuWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Kudzu"
  end
end
