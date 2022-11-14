defmodule Gscraper.Search.SearchResultParser do
  @top_ads_selector "#tads .uEierd"
  @top_ads_link_selector "#tads a"
  @sidebar_ads_selector ".Yi78Pd .pla-unit"
  @organic_link_selector "#search .g"
  @organic_result_selector "#search .g a"
  @href_attribute "a[href]"

  def parse(raw_html) do
    case Floki.parse_document(raw_html) do
      {:ok, parsed_html} ->
        results = %{
          ads_count: get_ads_count(parsed_html),
          top_ads_count: get_top_ads_count(parsed_html),
          top_ads_urls: get_top_ads_urls(parsed_html),
          organic_result_count: get_organic_result_count(parsed_html),
          organic_urls: get_organic_urls(parsed_html),
          link_count: get_link_count(parsed_html),
          raw_html: raw_html
        }

        {:ok, results}

      {:error, reason} ->
        {:error, :failed_to_parse, reason}
    end
  end

  defp get_ads_count(parsed_html),
    do: get_sidebar_ads_count(parsed_html) + get_top_ads_count(parsed_html)

  defp get_sidebar_ads_count(parsed_html) do
    parsed_html
    |> Floki.find(@sidebar_ads_selector)
    |> Enum.count()
  end

  defp get_top_ads_count(parsed_html) do
    parsed_html
    |> Floki.find(@top_ads_selector)
    |> Enum.count()
  end

  defp get_top_ads_urls(parsed_html) do
    parsed_html
    |> Floki.find(@top_ads_link_selector)
    |> Floki.attribute(@href_attribute)
  end

  defp get_organic_result_count(parsed_html) do
    parsed_html
    |> Floki.find(@organic_link_selector)
    |> Enum.count()
  end

  defp get_organic_urls(parsed_html) do
    parsed_html
    |> Floki.find(@organic_result_selector)
    |> Floki.attribute(@href_attribute)
  end

  defp get_link_count(parsed_html) do
    parsed_html
    |> Floki.find(@organic_link_selector)
    |> Enum.count()
  end
end
