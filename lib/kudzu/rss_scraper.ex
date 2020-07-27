defmodule Kudzu.RSSScraper do
  def fetch_feed(url, source_feed_id) do
    { :ok, %HTTPoison.Response{body: body} } = HTTPoison.get(url)
    feed = ElixirFeedParser.parse(body)

    Enum.map feed.entries, fn(entry) ->
      # TODO: I think I'm getting a bad arg argument here
      case Timex.parse(entry."rss2:pubDate", "{RFC1123}") do
        { :ok, published_date } ->
          insert_article(%{
            title:          entry.title,
            description:    entry.description,
            url:            entry.url,
            published_date: published_date,
            feed_id:        source_feed_id
          })
        { :error, err } -> IO.puts("#{err} - #{entry."rss2:pubDate"}")
      end
    end

    { :ok, Enum.count(feed.entries) }
  end

  def insert_article(article) do
    { :ok, article } = Kudzu.Articles.create_or_update_article(article)

    article |> Kudzu.Articles.set_automatic_topics

    article
  end
end
