defmodule Gscraper.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Gscraper.Repo,
      # Start the Telemetry supervisor
      GscraperWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Gscraper.PubSub},
      # Start the Endpoint (http/https)
      GscraperWeb.Endpoint,
      {Oban, oban_config()}
      # Start a worker by calling: Gscraper.Worker.start_link(arg)
      # {Gscraper.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gscraper.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    GscraperWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  # Conditionally disable crontab, queues, or plugins here.
  defp oban_config do
    Application.get_env(:gscraper, Oban)
  end
end
