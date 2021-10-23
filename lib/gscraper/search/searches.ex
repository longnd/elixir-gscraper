defmodule Gscraper.Search.Searches do
  alias Gscraper.Account.Schemas.User
  alias Gscraper.Repo
  alias Gscraper.Search.Queries.KeywordQuery
  alias Gscraper.Search.Schemas.{Keyword, KeywordFile}

  def list_keywords_by_user(user) do
    user
    |> KeywordQuery.list_by_user()
    |> Repo.all()
  end

  def parse_keyword_form_file(file_path) do
    KeywordFile.parse(file_path)
  end

  def create_keyword(attrs \\ %{}) do
    %Keyword{}
    |> Keyword.create_changeset(attrs)
    |> Repo.insert()
  end

  def process_keyword_list(keyword_list, %User{id: user_id}) do
    Enum.each(keyword_list, fn keyword ->
      create_params = %{
        user_id: user_id,
        keyword: List.first(keyword)
      }

      Ecto.Multi.new()
      |> Ecto.Multi.run(:keyword, fn _, _ -> create_keyword(create_params) end)
      # Todo: enqueue a new search job for the given keyword
      |> Repo.transaction()
    end)
  end
end
