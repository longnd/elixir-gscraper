defmodule Gscraper.Search.Schemas.KeywordFile do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :file, :map
  end

  @csv_file_ext ".csv"
  @csv_mime_type "text/csv"

  def create_changeset(keyword_file, attrs \\ %{}) do
    keyword_file
    |> cast(attrs, [:file])
    |> validate_required([:file])
    |> validate_file_type()
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
end
