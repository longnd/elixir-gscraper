defmodule GscraperWeb.Repo do
  use Ecto.Repo,
    otp_app: :gscraper_web,
    adapter: Ecto.Adapters.Postgres
end
