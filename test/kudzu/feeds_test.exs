defmodule Kudzu.FeedsTest do
  use Kudzu.DataCase

  alias Kudzu.Feeds

  describe "feeds" do
    alias Kudzu.Feeds.Feed

    @valid_attrs %{description: "some description", logo_url: "some logo_url", slug: "some slug", title: "some title", url: "some url"}
    @update_attrs %{description: "some updated description", logo_url: "some updated logo_url", slug: "some updated slug", title: "some updated title", url: "some updated url"}
    @invalid_attrs %{description: nil, logo_url: nil, slug: nil, title: nil, url: nil}

    def feed_fixture(attrs \\ %{}) do
      {:ok, feed} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Feeds.create_feed()

      feed
    end

    test "list_feeds/0 returns all feeds" do
      feed = feed_fixture()
      assert Feeds.list_feeds() == [feed]
    end

    test "get_feed!/1 returns the feed with given id" do
      feed = feed_fixture()
      assert Feeds.get_feed!(feed.id) == feed
    end

    test "create_feed/1 with valid data creates a feed" do
      assert {:ok, %Feed{} = feed} = Feeds.create_feed(@valid_attrs)
      assert feed.description == "some description"
      assert feed.logo_url == "some logo_url"
      assert feed.slug == "some slug"
      assert feed.title == "some title"
      assert feed.url == "some url"
    end

    test "create_feed/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Feeds.create_feed(@invalid_attrs)
    end

    test "update_feed/2 with valid data updates the feed" do
      feed = feed_fixture()
      assert {:ok, %Feed{} = feed} = Feeds.update_feed(feed, @update_attrs)
      assert feed.description == "some updated description"
      assert feed.logo_url == "some updated logo_url"
      assert feed.slug == "some updated slug"
      assert feed.title == "some updated title"
      assert feed.url == "some updated url"
    end

    test "update_feed/2 with invalid data returns error changeset" do
      feed = feed_fixture()
      assert {:error, %Ecto.Changeset{}} = Feeds.update_feed(feed, @invalid_attrs)
      assert feed == Feeds.get_feed!(feed.id)
    end

    test "delete_feed/1 deletes the feed" do
      feed = feed_fixture()
      assert {:ok, %Feed{}} = Feeds.delete_feed(feed)
      assert_raise Ecto.NoResultsError, fn -> Feeds.get_feed!(feed.id) end
    end

    test "change_feed/1 returns a feed changeset" do
      feed = feed_fixture()
      assert %Ecto.Changeset{} = Feeds.change_feed(feed)
    end
  end
end
