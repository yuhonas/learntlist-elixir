# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :learnt_list,
  ecto_repos: [LearntList.Repo]

# Configures the endpoint
config :learnt_list, LearntListWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bpnbN9vK5LbxqbD9rSPmrQ5G01krdGD9NMTnRZEHGTtklvrVhRGPmI0Cdfg/ae31",
  render_errors: [view: LearntListWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: LearntList.PubSub,
  live_view: [signing_salt: "wamEkvdS"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
