defmodule Gscraper.MixProject do
  use Mix.Project

  def project do
    [
      app: :gscraper,
      version: "0.1.0",
      elixir: "~> 1.12.2",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        lint: :test,
        coverage: :test,
        coveralls: :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Gscraper.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support", "test/factories"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:argon2_elixir, "~> 2.0"},
      {:wallaby, "~> 0.28.0", [only: :test, runtime: false]},
      {:sobelow, "~> 0.11.1", [only: [:dev, :test], runtime: false]},
      {:oban, "~> 2.6.1"},
      {:mimic, "~> 1.4.0", [only: :test]},
      {:ex_machina, "~> 2.7.0", [only: :test]},
      {:excoveralls, "~> 0.14.0", [only: :test]},
      {:faker, "~> 0.16", only: :test},
      {:dialyxir, "~> 1.1.0", [only: [:dev], runtime: false]},
      {:credo, "~> 1.5.6", [only: [:dev, :test], runtime: false]},
      {:phoenix, "~> 1.5.12"},
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.7"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 3.0"},
      {:phoenix_live_reload, "~> 1.3", only: :dev},
      {:phoenix_live_dashboard, "~> 0.5"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.5"},
      {:guardian, "~> 2.0"},
      {:nimble_csv, "~> 1.1"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      "assets.compile": &compile_assets/1,
      coverage: ["coveralls.html --raise"],
      codebase: [
        "cmd npm run eslint --prefix assets",
        "cmd npm run stylelint --prefix assets",
        "deps.unlock --check-unused",
        "format --check-formatted",
        "credo --strict",
        "sobelow --config"
      ],
      "codebase.fix": [
        "cmd npm run eslint.fix --prefix assets",
        "cmd npm run stylelint.fix --prefix assets",
        "deps.clean --unlock --unused",
        "format"
      ],
      setup: ["deps.get", "ecto.setup", "cmd npm install --prefix assets"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end

  defp compile_assets(_) do
    Mix.shell().cmd("npm run --prefix assets build:dev", quiet: true)
  end
end
