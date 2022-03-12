defmodule Gscraper.Search.ScraperWorker do
  use Oban.Worker, max_attempts: 10, unique: [period: 30]

  alias Gscraper.Search.Searches



  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"keyword_id" => keyword_id}}) do
    keyword = Searches.find_keyword_by_id!(keyword_id)

    keyword
  end


end
