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

Kudzu.Feeds.create_feed(%{
  title: "New York Times",
  description: "The New York Times provides breaking news, multimedia, reviews & opinion on Washington, business, sports, movies, travel, books, jobs, education, real estate, cars & more.",
  url: "https://rss.nytimes.com/services/xml/rss/nyt/HomePage.xml",
  slug: "new_york_times",
  logo_url: "https://upload.wikimedia.org/wikipedia/commons/7/77/The_New_York_Times_logo.png"
})

Kudzu.Feeds.create_feed(%{
  title: "Politico",
  description: "POLITICO launched in January 2007 with the mission of covering the politics of Capitol Hill, the presidential campaign, and the business of Washington lobbying and advocacy with enterprise, style, and impact. Political news about Congress, the White House, campaigns, lobbyists and issues.",
  url: "https://www.politico.com/rss/politicopicks.xml",
  slug: "politico",
  logo_url: "https://static.politico.com/da/f5/44342c424c68b675719324b1106b/politico.jpg"
})

Kudzu.Feeds.create_feed(%{
  title: "NPR",
  description: "NPR delivers breaking national and world news. Also top stories from business, politics, health, science, technology, music, arts and culture.",
  url: "https://feeds.npr.org/1001/rss.xml",
  slug: "npr",
  logo_url: "https://media.npr.org/assets/img/2019/06/17/nprlogo_rgb_whiteborder_custom-7c06f2837fb5d2e65e44de702968d1fdce0ce748-s1500-c85.png"
})

Kudzu.Feeds.create_feed(%{
  title: "Breitbart",
  description: "Breitbart News is a conservative news and opinion website founded by the late Andrew Breitbart. Breitbart News Network is a syndicated news and opinion website providing continuously updated headlines to top news and analysis sources.",
  url: "http://feeds.feedburner.com/breitbart",
  slug: "breitbart",
  logo_url: "https://en.wikipedia.org/wiki/Breitbart_News#/media/File:Breitbart_News.svg"
})

Kudzu.Feeds.create_feed(%{
  title: "Mother Jones",
  description: "Smart, fearless journalism",
  url: "http://feeds.feedburner.com/KevinDrum",
  slug: "mother_jones",
  logo_url: "https://www.motherjones.com/wp-content/themes/motherjones/img/mj-nomaster-2000-1124.jpg"
})
