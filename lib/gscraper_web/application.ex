defmodule GscraperWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      GscraperWeb.Repo,
      # Start the Telemetry supervisor
      GscraperWebWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: GscraperWeb.PubSub},
      # Start the Endpoint (http/https)
      GscraperWebWeb.Endpoint,
      {Oban, oban_config()}
      # Start a worker by calling: GscraperWeb.Worker.start_link(arg)
      # {GscraperWeb.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GscraperWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    GscraperWebWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  # Conditionally disable crontab, queues, or plugins here.
  defp oban_config do
    Application.get_env(:gscraper_web, Oban)
  end
end
