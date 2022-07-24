defmodule Gscraper.Search.ScraperWorker do
  use Oban.Worker, max_attempts: 10, unique: [period: 30]

  alias Gscraper.Search.Schemas.Keyword
  alias Gscraper.Search.{Scraper, Searches}

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"keyword_id" => keyword_id}}) do
    with {%Keyword{} = keyword} <- Searches.find_keyword_by_id(keyword_id),
         {:ok, parsed_result} <- Scraper.scrape(keyword),
         {:ok, _} <- Searches.create_report(keyword, parsed_result) do
      :ok
    else
      {:error, :not_found} ->
        {:error, "Keyword not found for ID: #{keyword_id}"}

      {:error, :failed_to_parse, reason} ->
        {:error, reason}

      {:error, :http_client_error, reason} ->
        {:error, reason}
    end
  end
end
