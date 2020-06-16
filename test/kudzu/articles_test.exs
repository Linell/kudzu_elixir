defmodule Kudzu.ArticlesTest do
  use Kudzu.DataCase

  alias Kudzu.Articles

  describe "articles" do
    alias Kudzu.Articles.Article

    @valid_attrs %{description: "some description", published_date: ~N[2010-04-17 14:00:00], title: "some title", url: "some url"}
    @update_attrs %{description: "some updated description", published_date: ~N[2011-05-18 15:01:01], title: "some updated title", url: "some updated url"}
    @invalid_attrs %{description: nil, published_date: nil, title: nil, url: nil}

    def article_fixture(attrs \\ %{}) do
      {:ok, article} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Articles.create_article()

      article
    end

    test "list_articles/0 returns all articles" do
      article = article_fixture()
      assert Articles.list_articles() == [article]
    end

    test "get_article!/1 returns the article with given id" do
      article = article_fixture()
      assert Articles.get_article!(article.id) == article
    end

    test "create_article/1 with valid data creates a article" do
      assert {:ok, %Article{} = article} = Articles.create_article(@valid_attrs)
      assert article.description == "some description"
      assert article.published_date == ~N[2010-04-17 14:00:00]
      assert article.title == "some title"
      assert article.url == "some url"
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Articles.create_article(@invalid_attrs)
    end

    test "update_article/2 with valid data updates the article" do
      article = article_fixture()
      assert {:ok, %Article{} = article} = Articles.update_article(article, @update_attrs)
      assert article.description == "some updated description"
      assert article.published_date == ~N[2011-05-18 15:01:01]
      assert article.title == "some updated title"
      assert article.url == "some updated url"
    end

    test "update_article/2 with invalid data returns error changeset" do
      article = article_fixture()
      assert {:error, %Ecto.Changeset{}} = Articles.update_article(article, @invalid_attrs)
      assert article == Articles.get_article!(article.id)
    end

    test "delete_article/1 deletes the article" do
      article = article_fixture()
      assert {:ok, %Article{}} = Articles.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> Articles.get_article!(article.id) end
    end

    test "change_article/1 returns a article changeset" do
      article = article_fixture()
      assert %Ecto.Changeset{} = Articles.change_article(article)
    end
  end
end
