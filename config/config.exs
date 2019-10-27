# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :example, Example.Repo,
  database: "basic",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :example,
  ecto_repos: [Example.Repo]

# Configures the endpoint
config :example, ExampleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "GDfhPu29ZU0xorkCWh4TcdGKGVNEtK/AbDz6GB0zEhqzEWKq6xUrC7UKmNsIPQLY",
  render_errors: [view: ExampleWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Example.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
     signing_salt: "AtLq86+3Rzo8/Du50+uUd6frCcZkCu5m"
  ]

# Phauxth authentication configuration
config :phauxth,
  user_context: Example.Accounts,
  crypto_module: Argon2,
  token_module: ExampleWeb.Auth.Token

# Mailer configuration
config :example, ExampleWeb.Mailer,
  adapter: Bamboo.LocalAdapter

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
