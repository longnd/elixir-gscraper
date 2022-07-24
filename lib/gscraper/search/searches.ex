defmodule Gscraper.Search.Searches do
  alias Gscraper.Account.Schemas.User
  alias Gscraper.Repo
  alias Gscraper.Search.Queries.KeywordQuery
  alias Gscraper.Search.Schemas.{Keyword, Report}
  alias Gscraper.Search.ScraperWorker

  def find_keyword_by_id(id), do: Repo.get(Keyword, id)

  def list_keywords_by_user(user) do
    user
    |> KeywordQuery.list_by_user()
    |> Repo.all()
  end

  def create_keyword(attrs \\ %{}) do
    %Keyword{}
    |> Keyword.create_changeset(attrs)
    |> Repo.insert()
  end

  def process_keyword_list(keyword_list, %User{id: user_id}) do
    Enum.each(keyword_list, fn keyword ->
      create_params = %{user_id: user_id, keyword: keyword}

      Ecto.Multi.new()
      |> Ecto.Multi.run(:create_keyword, fn _, _ -> create_keyword(create_params) end)
      |> Ecto.Multi.run(:enqueue_search_job, fn _, %{keyword: keyword} ->
        enqueue_search_job(keyword)
      end)
      |> Repo.transaction()
    end)
  end

  def create_report(%Keyword{} = keyword, attrs \\ %{}) do
    keyword
    |> Ecto.build_assoc(:report)
    |> Report.create_changeset(attrs)
    |> Repo.insert()
  end

  defp enqueue_search_job(%Keyword{id: keyword_id}) do
    %{keyword_id: keyword_id}
    |> ScraperWorker.new()
    |> Oban.insert()
  end
end
