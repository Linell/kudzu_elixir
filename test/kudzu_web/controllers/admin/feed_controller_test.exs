defmodule KudzuWeb.Admin.FeedControllerTest do
  use KudzuWeb.ConnCase

  alias Kudzu.Feeds

  @create_attrs %{body: "some body", description: "some description", logo_url: "some logo_url", slug: "some slug", title: "some title", url: "some url"}
  @update_attrs %{body: "some updated body", description: "some updated description", logo_url: "some updated logo_url", slug: "some updated slug", title: "some updated title", url: "some updated url"}
  @invalid_attrs %{body: nil, description: nil, logo_url: nil, slug: nil, title: nil, url: nil}

  def fixture(:feed) do
    {:ok, feed} = Feeds.create_feed(@create_attrs)
    feed
  end

  describe "index" do
    test "lists all feeds", %{conn: conn} do
      conn = get conn, Routes.admin_feed_path(conn, :index)
      assert html_response(conn, 200) =~ "Feeds"
    end
  end

  describe "new feed" do
    test "renders form", %{conn: conn} do
      conn = get conn, Routes.admin_feed_path(conn, :new)
      assert html_response(conn, 200) =~ "New Feed"
    end
  end

  describe "create feed" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, Routes.admin_feed_path(conn, :create), feed: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.admin_feed_path(conn, :show, id)

      conn = get conn, Routes.admin_feed_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Feed Details"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, Routes.admin_feed_path(conn, :create), feed: @invalid_attrs
      assert html_response(conn, 200) =~ "New Feed"
    end
  end

  describe "edit feed" do
    setup [:create_feed]

    test "renders form for editing chosen feed", %{conn: conn, feed: feed} do
      conn = get conn, Routes.admin_feed_path(conn, :edit, feed)
      assert html_response(conn, 200) =~ "Edit Feed"
    end
  end

  describe "update feed" do
    setup [:create_feed]

    test "redirects when data is valid", %{conn: conn, feed: feed} do
      conn = put conn, Routes.admin_feed_path(conn, :update, feed), feed: @update_attrs
      assert redirected_to(conn) == Routes.admin_feed_path(conn, :show, feed)

      conn = get conn, Routes.admin_feed_path(conn, :show, feed)
      assert html_response(conn, 200) =~ "some updated body"
    end

    test "renders errors when data is invalid", %{conn: conn, feed: feed} do
      conn = put conn, Routes.admin_feed_path(conn, :update, feed), feed: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Feed"
    end
  end

  describe "delete feed" do
    setup [:create_feed]

    test "deletes chosen feed", %{conn: conn, feed: feed} do
      conn = delete conn, Routes.admin_feed_path(conn, :delete, feed)
      assert redirected_to(conn) == Routes.admin_feed_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, Routes.admin_feed_path(conn, :show, feed)
      end
    end
  end

  defp create_feed(_) do
    feed = fixture(:feed)
    {:ok, feed: feed}
  end
end
