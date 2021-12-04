defmodule Gscraper.Search.Schemas.Report do
  use Ecto.Schema
  import Ecto.Changeset

  alias Gscraper.Search.Schemas.Keyword

  schema "keywords" do
    field :ads_link_count, :integer
    field :top_ads_link_count, :integer
    field :top_ads_link_list, {:array, :string}
    field :organic_link_count, :integer
    field :organic_link_list, {:array, :string}
    field :link_count, :integer
    field :html_content, :text

    timestamps()

    belongs_to :keyword, Keyword

    timestamps()
  end

  def create_changeset(report \\ %__MODULE__{}, attrs) do
  end
end
