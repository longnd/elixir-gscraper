use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :gscraper_web, GscraperWeb.Repo,
  username: "postgres",
  password: "postgres",
  database: "gscraper_web_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: System.get_env("DB_HOST") || "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :gscraper_web, GscraperWebWeb.Endpoint,
  http: [port: 4002],
  server: true

config :gscraper_web, :sql_sandbox, true

config :wallaby,
  otp_app: :gscraper_web,
  chromedriver: [headless: System.get_env("CHROME_HEADLESS", "true") === "true"],
  screenshot_dir: "tmp/wallaby_screenshots",
  screenshot_on_failure: true

# Print only warnings and errors during test
config :logger, level: :warn

config :gscraper_web, Oban, crontab: false, queues: false, plugins: false
