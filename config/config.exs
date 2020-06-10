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
  pubsub: [name: Kudzu.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "ZdfC2kt8"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
