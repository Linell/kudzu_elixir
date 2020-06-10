defmodule Kudzu.RSSScraper do
  def fetch_feed do
    url  = cnn_url
    { :ok, %HTTPoison.Response{body: body} } = HTTPoison.get(url)
    feed = ElixirFeedParser.parse(body)

    IO.puts(feed.title)
    Enum.map feed.entries, fn(entry) -> IO.puts(entry.title) end

    feed
  end

  def cnn_url do
    "http://rss.cnn.com/rss/cnn_topstories.rss"
  end
end
