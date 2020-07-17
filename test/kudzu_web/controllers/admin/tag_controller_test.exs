defmodule KudzuWeb.Admin.TagControllerTest do
  use KudzuWeb.ConnCase

  alias Kudzu.Tags

  @create_attrs %{id: 42, inserted_at: ~N[2010-04-17 14:00:00], tag: "some tag", updated_at: ~N[2010-04-17 14:00:00]}
  @update_attrs %{id: 43, inserted_at: ~N[2011-05-18 15:01:01], tag: "some updated tag", updated_at: ~N[2011-05-18 15:01:01]}
  @invalid_attrs %{id: nil, inserted_at: nil, tag: nil, updated_at: nil}

  def fixture(:tag) do
    {:ok, tag} = Tags.create_tag(@create_attrs)
    tag
  end

  describe "index" do
    test "lists all tags", %{conn: conn} do
      conn = get conn, Routes.admin_tag_path(conn, :index)
      assert html_response(conn, 200) =~ "Tags"
    end
  end

  describe "new tag" do
    test "renders form", %{conn: conn} do
      conn = get conn, Routes.admin_tag_path(conn, :new)
      assert html_response(conn, 200) =~ "New Tag"
    end
  end

  describe "create tag" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, Routes.admin_tag_path(conn, :create), tag: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.admin_tag_path(conn, :show, id)

      conn = get conn, Routes.admin_tag_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Tag Details"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, Routes.admin_tag_path(conn, :create), tag: @invalid_attrs
      assert html_response(conn, 200) =~ "New Tag"
    end
  end

  describe "edit tag" do
    setup [:create_tag]

    test "renders form for editing chosen tag", %{conn: conn, tag: tag} do
      conn = get conn, Routes.admin_tag_path(conn, :edit, tag)
      assert html_response(conn, 200) =~ "Edit Tag"
    end
  end

  describe "update tag" do
    setup [:create_tag]

    test "redirects when data is valid", %{conn: conn, tag: tag} do
      conn = put conn, Routes.admin_tag_path(conn, :update, tag), tag: @update_attrs
      assert redirected_to(conn) == Routes.admin_tag_path(conn, :show, tag)

      conn = get conn, Routes.admin_tag_path(conn, :show, tag)
      assert html_response(conn, 200) =~ "some updated tag"
    end

    test "renders errors when data is invalid", %{conn: conn, tag: tag} do
      conn = put conn, Routes.admin_tag_path(conn, :update, tag), tag: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Tag"
    end
  end

  describe "delete tag" do
    setup [:create_tag]

    test "deletes chosen tag", %{conn: conn, tag: tag} do
      conn = delete conn, Routes.admin_tag_path(conn, :delete, tag)
      assert redirected_to(conn) == Routes.admin_tag_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, Routes.admin_tag_path(conn, :show, tag)
      end
    end
  end

  defp create_tag(_) do
    tag = fixture(:tag)
    {:ok, tag: tag}
  end
end
