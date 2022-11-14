defmodule Gscraper.Search.Schemas.Report do
  use Ecto.Schema
  import Ecto.Changeset

  alias Gscraper.Search.Schemas.Keyword

  # credo:disable-for-next-line Credo.Check.Readability.MaxLineLength
  @fields ~w(ads_count top_ads_count top_ads_urls organic_result_count organic_urls links_count raw_html)

  schema "keywords" do
    field :ads_count, :integer
    field :top_ads_count, :integer
    field :top_ads_urls, {:array, :string}
    field :organic_result_count, :integer
    field :organic_urls, {:array, :string}
    field :links_count, :integer
    field :raw_html, :string

    belongs_to :keyword, Keyword

    timestamps()
  end

  def create_changeset(report \\ %__MODULE__{}, attrs) do
    report
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> assoc_constraint(:keyword)
  end
end
