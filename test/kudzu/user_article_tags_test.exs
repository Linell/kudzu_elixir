defmodule Kudzu.UserArticleTagsTest do
  use Kudzu.DataCase

  alias Kudzu.UserArticleTags

  describe "user_article_tags" do
    alias Kudzu.UserArticleTags.UserArticleTag

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def user_article_tag_fixture(attrs \\ %{}) do
      {:ok, user_article_tag} =
        attrs
        |> Enum.into(@valid_attrs)
        |> UserArticleTags.create_user_article_tag()

      user_article_tag
    end

    test "list_user_article_tags/0 returns all user_article_tags" do
      user_article_tag = user_article_tag_fixture()
      assert UserArticleTags.list_user_article_tags() == [user_article_tag]
    end

    test "get_user_article_tag!/1 returns the user_article_tag with given id" do
      user_article_tag = user_article_tag_fixture()
      assert UserArticleTags.get_user_article_tag!(user_article_tag.id) == user_article_tag
    end

    test "create_user_article_tag/1 with valid data creates a user_article_tag" do
      assert {:ok, %UserArticleTag{} = user_article_tag} = UserArticleTags.create_user_article_tag(@valid_attrs)
    end

    test "create_user_article_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserArticleTags.create_user_article_tag(@invalid_attrs)
    end

    test "update_user_article_tag/2 with valid data updates the user_article_tag" do
      user_article_tag = user_article_tag_fixture()
      assert {:ok, %UserArticleTag{} = user_article_tag} = UserArticleTags.update_user_article_tag(user_article_tag, @update_attrs)
    end

    test "update_user_article_tag/2 with invalid data returns error changeset" do
      user_article_tag = user_article_tag_fixture()
      assert {:error, %Ecto.Changeset{}} = UserArticleTags.update_user_article_tag(user_article_tag, @invalid_attrs)
      assert user_article_tag == UserArticleTags.get_user_article_tag!(user_article_tag.id)
    end

    test "delete_user_article_tag/1 deletes the user_article_tag" do
      user_article_tag = user_article_tag_fixture()
      assert {:ok, %UserArticleTag{}} = UserArticleTags.delete_user_article_tag(user_article_tag)
      assert_raise Ecto.NoResultsError, fn -> UserArticleTags.get_user_article_tag!(user_article_tag.id) end
    end

    test "change_user_article_tag/1 returns a user_article_tag changeset" do
      user_article_tag = user_article_tag_fixture()
      assert %Ecto.Changeset{} = UserArticleTags.change_user_article_tag(user_article_tag)
    end
  end
end
