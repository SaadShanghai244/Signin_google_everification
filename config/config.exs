# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :practice_task2,
  ecto_repos: [PracticeTask2.Repo]

config :practice_task2, PracticeTask2.Mailer,
  # adapter: Bamboo.MandrillAdapter,


  # config :practice_task2, PracticeTask2.SendGridMailer,
  # adapter: Bamboo.SendGridAdapter,


  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "xxxxxxxxxxxxxxxx"

config :practice_task2, PracticeTask2.Mailer,
  adapter: Swoosh.Adapters.SMTP,
  relay: "smtp.gmail.com",
  username: {:system, "@gmail.com"},
  password: {:system, ""},
  tls: :always

  config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "Sample",
  ttl: { 30, :days },
  allowed_drift: 2000,
  verify_issuer: true, # optional
  secret_key: System.get_env("GUARDIAN_SECRET") || "xx...xxxx",
  serializer: Sample.Web.GuardianSerializer
  # config :sample, Sample.Mailer,
  # adapter: Swoosh.Adapters.SMTP,
  # relay: "smtp.sendgrid.net"
  # username: {:system, "SMTP_USERNAME"},
  # password: {:system, "SMTP_PASSWORD"},
  # tls: :always

# Configures the endpoint
config :practice_task2, PracticeTask2Web.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: PracticeTask2Web.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PracticeTask2.PubSub,
  live_view: [signing_salt: "2d2ziKU7"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.

config :practice_task2, PracticeTask2.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args: ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]
  config :practice_task2, PracticeTask2.Guardian,
  issuer: "practice_task2",
  secret_key: "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
