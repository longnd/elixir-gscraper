defmodule Gscraper.Search.Searches do
  alias Gscraper.Search.Queries.KeywordQuery
  alias Gscraper.Repo

  require Logger

  def list_keywords_by_user(user) do
    user
    |> KeywordQuery.list_by_user()
    |> Repo.all()
  end
end