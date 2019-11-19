# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :app, App.Repo,
  database: "basic",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :app,
  ecto_repos: [App.Repo]

# Configures the endpoint
config :app, AppWeb.Endpoint,
  url: [host: System.get_env("HOST")],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  render_errors: [view: AppWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: App.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
     signing_salt: "AtLq86+3Rzo8/Du50+uUd6frCcZkCu5m"
  ]

# Phauxth authentication configuration
config :phauxth,
  user_context: App.Accounts,
  crypto_module: Argon2,
  token_module: AppWeb.Auth.Token

# Mailer configuration
config :app, AppWeb.Mailer,
  adapter: Bamboo.SMTPAdapter, #Bamboo.LocalAdapter
  server: "smtp.sendgrid.net",
  hostname: System.get_env("HOST"),
  port: 587, #587,
  username: System.get_env("SMTP_USERNAME"),
  password: System.get_env("SMTP_PASSWORD"),
  tls: :if_available, # can be `:always` or `:never`
  ssl: false, # can be `true`
  retries: 1

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Start grpc server
config :grpc, start_server: true

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
