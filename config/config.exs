# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :gscraper,
  ecto_repos: [Gscraper.Repo]

# Configures the endpoint
config :gscraper, GscraperWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "eD7Se7buNmNTWKhQrm2BFP3zlasjrQtg85ORlQ0PKqxtWq9FQetj8vOp1GIOZnyj",
  render_errors: [view: GscraperWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Gscraper.PubSub,
  live_view: [signing_salt: "/rYmGmhG"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :gscraper, Oban,
  repo: Gscraper.Repo,
  plugins: [Oban.Plugins.Pruner],
  queues: [default: 10]

# Configures Guardian
config :gscraper, Gscraper.Account.Authentications,
  issuer: "gscraper",
  secret_key: "6ofVI1NixLwA+JLAc6VE5+OEsqbIojNPoO5KE76wpq6thaiwAwxG2fG7E/Biytac"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
