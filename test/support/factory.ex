defmodule Gscraper.Factory do
  use ExMachina.Ecto, repo: Gscraper.Repo

  # Define your factories in /test/factories and declare it here,
  use Gscraper.Accounts.UserFactory
end
