defmodule Gscraper.Search.Searches do
  alias Gscraper.Repo
  alias Gscraper.Search.Queries.KeywordQuery
  alias Gscraper.Search.Schemas.KeywordFile

  def list_keywords_by_user(user) do
    user
    |> KeywordQuery.list_by_user()
    |> Repo.all()
  end

  def parse_keyword_form_file(file_path) do
    KeywordFile.parse(file_path)
  end
end
