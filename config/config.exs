# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :elixir_conf_live_view, ElixirConfLiveViewWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "f1iVJC6o/XfBBzAkb7frHUCpZbIj25OqG72xxXT5sxJeTQZod5rOP+UQbJAohpj9",
  render_errors: [view: ElixirConfLiveViewWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ElixirConfLiveView.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "+uknQVvMh3UVag+w05kPRc+tR3NgYW0/6PSr2YSXZFBw5FxCSLiEsPdmYqgjJZT+"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix,
  json_library: Jason,
  template_engines: [leex: Phoenix.LiveView.Engine]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
