# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :kudzu,
  ecto_repos: [Kudzu.Repo]

# Configures the endpoint
config :kudzu, KudzuWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "PwMOTQkeI4lIc6B+U/5Z8RLkA03k7dfsnQCMWRKtJoLkshGlp1lOb6BFk+s1asx2",
  render_errors: [view: KudzuWeb.ErrorView, accepts: ~w(html json)],
  pubsub_server: Kudzu.PubSub,
  live_view: [signing_salt: "k7SIqKHJLdPRqR49aiMCBJ87JLQ8Q+Zt"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :kudzu, Kudzu.Scheduler,
  jobs: [
    { "*/15 * * * *", { Kudzu.Feeds, :scrape_all_feeds, [] }}
  ]

config :kudzu, :pow,
  user: Kudzu.Users.User,
  repo: Kudzu.Repo,
  web_module: KudzuWeb

config :torch,
  otp_app: :kudzu,
  template_format: "eex" || "slime"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
