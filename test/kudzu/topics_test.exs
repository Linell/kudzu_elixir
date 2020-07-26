defmodule Kudzu.TopicsTest do
  use Kudzu.DataCase

  alias Kudzu.Topics

  describe "topics" do
    alias Kudzu.Topics.Topic

    @valid_attrs %{description: "some description", matches: %{}, preferred_tag_id: 42, title: "some title"}
    @update_attrs %{description: "some updated description", matches: %{}, preferred_tag_id: 43, title: "some updated title"}
    @invalid_attrs %{description: nil, matches: nil, preferred_tag_id: nil, title: nil}

    def topic_fixture(attrs \\ %{}) do
      {:ok, topic} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Topics.create_topic()

      topic
    end

    test "paginate_topics/1 returns paginated list of topics" do
      for _ <- 1..20 do
        topic_fixture()
      end

      {:ok, %{topics: topics} = page} = Topics.paginate_topics(%{})

      assert length(topics) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end

    test "list_topics/0 returns all topics" do
      topic = topic_fixture()
      assert Topics.list_topics() == [topic]
    end

    test "get_topic!/1 returns the topic with given id" do
      topic = topic_fixture()
      assert Topics.get_topic!(topic.id) == topic
    end

    test "create_topic/1 with valid data creates a topic" do
      assert {:ok, %Topic{} = topic} = Topics.create_topic(@valid_attrs)
      assert topic.description == "some description"
      assert topic.matches == %{}
      assert topic.preferred_tag_id == 42
      assert topic.title == "some title"
    end

    test "create_topic/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Topics.create_topic(@invalid_attrs)
    end

    test "update_topic/2 with valid data updates the topic" do
      topic = topic_fixture()
      assert {:ok, topic} = Topics.update_topic(topic, @update_attrs)
      assert %Topic{} = topic
      assert topic.description == "some updated description"
      assert topic.matches == %{}
      assert topic.preferred_tag_id == 43
      assert topic.title == "some updated title"
    end

    test "update_topic/2 with invalid data returns error changeset" do
      topic = topic_fixture()
      assert {:error, %Ecto.Changeset{}} = Topics.update_topic(topic, @invalid_attrs)
      assert topic == Topics.get_topic!(topic.id)
    end

    test "delete_topic/1 deletes the topic" do
      topic = topic_fixture()
      assert {:ok, %Topic{}} = Topics.delete_topic(topic)
      assert_raise Ecto.NoResultsError, fn -> Topics.get_topic!(topic.id) end
    end

    test "change_topic/1 returns a topic changeset" do
      topic = topic_fixture()
      assert %Ecto.Changeset{} = Topics.change_topic(topic)
    end
  end
end
