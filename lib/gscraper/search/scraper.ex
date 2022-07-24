defmodule Gscraper.Search.Scraper do
  alias Gscraper.Google.HttpClient, as: GoogleClient
  alias Gscraper.Search.SearchResultParser

  # credo:disable-for-lines:7 Credo.Check.Readability.MaxLineLength
  @user_agents [
    'Mozilla/5.0 (Windows NT 5.1; rv:2.0.1) Gecko/20100101 Firefox/4.0.1',
    'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36',
    'Mozilla/5.0 (Windows NT 6.0) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.112 Safari/535.1',
    'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.85 Safari/537.36',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:61.0) Gecko/20100101 Firefox/98.0',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0 Safari/605.1.15'
  ]

  def scrape(keyword) do
    with {:ok, raw_html} <- search_keyword(keyword),
         {:ok, parsed_result} <- SearchResultParser.parse(raw_html) do
      {:ok, parsed_result}
    else
      {:error, :failed_to_parse, reason} ->
        {:error, :failed_to_parse, "Failed to parse search result: #{inspect(reason)}"}

      {:error, reason} ->
        {:error, :http_client_error, "Search page cannot be fetched: #{inspect(reason)}"}
    end
  end

  defp search_keyword(keyword) do
    query_params = %{q: "#{keyword}"}
    headers = ["User-Agent": random_user_agent()]

    GoogleClient.get("search", query_params, headers)
  end

  defp random_user_agent, do: @user_agents |> Enum.shuffle() |> Enum.take(1)
end
