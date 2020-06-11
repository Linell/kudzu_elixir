# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Kudzu.Repo.insert!(%Kudzu.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Kudzu.Feeds.create_feed(%{
  title: "CNN",
  description: "CNN is an American news-based pay television channel owned by CNN Worldwide, a uniw of the WarnerMedia News & Sports division of AT&T's WarnerMedia.",
  url: "http://rss.cnn.com/rss/cnn_us.rss",
  slug: "cnn",
  logo_url: "https://upload.wikimedia.org/wikipedia/commons/b/b1/CNN.svg"
})

Kudzu.Feeds.create_feed(%{
  title: "Fox News",
  description: "Fox News is an American conservative cable television news channel. It is owned by FOX News Media, which itself is owned by the Fox Corporation.",
  url: "http://feeds.foxnews.com/foxnews/latest",
  slug: "fox",
  logo_url: "https://upload.wikimedia.org/wikipedia/commons/6/67/Fox_News_Channel_logo.svg"
})
