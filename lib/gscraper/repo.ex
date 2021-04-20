defmodule Gscraper.Repo do
  use Ecto.Repo,
    otp_app: :gscraper,
    adapter: Ecto.Adapters.Postgres
end
