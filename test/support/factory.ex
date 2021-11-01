defmodule Gscraper.Factory do
  use ExMachina.Ecto, repo: Gscraper.Repo

  # Define your factories in /test/factories and declare it here,
  use Gscraper.UserFactory
  use Gscraper.KeywordFactory
end
