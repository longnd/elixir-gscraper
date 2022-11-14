defmodule Gscraper.Google.HttpClient do
  @google_search_base_url "https://www.google.com"

  def get(path, query_params \\ %{}, headers \\ []) do
    client()
    |> Tesla.get(path, query: Map.to_list(query_params), header: headers)
    |> handle_response()
  end

  defp client do
    middleware = [
      {Tesla.Middleware.BaseUrl, @google_search_base_url}
    ]

    adapter = {Tesla.Adapter.Hackney, []}

    Tesla.client(middleware, adapter)
  end

  defp handle_response({:ok, %{status: status, body: body}}) when status in 200..299,
    do: {:ok, body}

  defp handle_response({:ok, %{status: status, body: body}}),
    do: {:error, %{status: status, body: body}}

  defp handle_response({:error, reason}), do: {:error, reason}
end
