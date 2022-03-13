defmodule Gscraper.Google.HttpClient do
  @google_search_base_url "https://www.google.com"
  @user_agents [
    'Mozilla/5.0 (Windows NT 5.1; rv:2.0.1) Gecko/20100101 Firefox/4.0.1',
    'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36',
    'Mozilla/5.0 (Windows NT 6.0) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.112 Safari/535.1',
    'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.85 Safari/537.36',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:61.0) Gecko/20100101 Firefox/98.0',
    'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0 Safari/605.1.15',
  ]

  def get(keyword) do
    headers = ["User-Agent": random_user_agent()]
    url = "search?q=#{keyword}"

    client() |> Tesla.get(url, headers: headers) |> handle_response()
  end

  defp client() do
    middleware = [
      {Tesla.Middleware.BaseUrl, @google_search_base_url}
    ]

    adapter = {Tesla.Adapter.Hackney}

    Tesla.client(middleware, adapter)
  end

  defp handle_response({:ok, %{status: status, body: body}}) when status in 200..299,
       do: {:ok, body}

  defp handle_response({:ok, %{status: status, body: body}}),
       do: {:error, %{status: status, body: body}}

  defp handle_response({:error, reason}), do: {:error, reason}

  defp random_user_agent(), do: @user_agents |> Enum.shuffle() |> Enum.take(1)
end
