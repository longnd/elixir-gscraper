defmodule Gscraper.Search.Schemas.KeywordFile do
  use Ecto.Schema

  import Ecto.Changeset

  alias NimbleCSV.RFC4180, as: CSV

  embedded_schema do
    field :file, :map
  end

  @csv_file_ext ".csv"
  @csv_mime_type "text/csv"
  @max_keyword_count 100

  def create_changeset(keyword_file, attrs \\ %{}) do
    keyword_file
    |> cast(attrs, [:file])
    |> validate_required([:file])
    |> validate_file_type()
  end

  def parse(file_path) do
    keyword_list = parse_with_headers(file_path)

    case length(keyword_list) do
      length when length <= 0 ->
        {:error, :file_is_empty}

      length when length > @max_keyword_count ->
        {:error, :keyword_list_exceeded}

      _ ->
        {:ok, keyword_list}
    end
  end

  defp validate_file_type(changeset) do
    validate_change(changeset, :file, fn :file, file ->
      if Path.extname(file.filename) == @csv_file_ext &&
           file.content_type == @csv_mime_type do
        []
      else
        [file: "is not a CSV file"]
      end
    end)
  end

  defp parse_with_headers(file_path) do
    file_path
    |> File.stream!()
    |> CSV.parse_stream()
    |> Enum.to_list()
    |> List.flatten()
  end
end
