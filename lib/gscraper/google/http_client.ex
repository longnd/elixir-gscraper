defmodule Gscraper.Google.HttpClient do
  @google_search_base_url "https://www.google.com/search?q="
  @user_agents [
    'Mozilla/5.0 (Windows NT 5.1; rv:2.0.1) Gecko/20100101 Firefox/4.0.1',
    'Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36',
    'Mozilla/5.0 (Windows NT 6.0) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.112 Safari/535.1',
    'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/40.0.2214.85 Safari/537.36',
  ]

  def get(keyword, header) do
    client() |> Tesla.post(url, body, headers: headers) |> handle_response()
  end

  defp client() do
    middleware = [
      {Tesla.Middleware.BaseUrl, @google_search_base_url},
      {Tesla.Middleware.Headers, [{"authorization", "token: " <> token }]}
    ]

    adapter = {Tesla.Adapter.Hackney}

    Tesla.client(middleware, adapter)
  end
end