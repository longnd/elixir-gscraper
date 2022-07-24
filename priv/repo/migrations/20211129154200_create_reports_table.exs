defmodule Gscraper.Repo.Migrations.CreateReportsTable do
  use Ecto.Migration

  def change do
    create table(:reports) do
      add :keyword_id, references(:keywords, on_delete: :delete_all)
      add :ads_count, :integer
      add :top_ads_count, :integer
      add :top_ads_urls, {:array, :string}
      add :organic_result_count, :integer
      add :organic_urls, {:array, :string}
      add :links_count, :integer
      add :raw_html, :string

      timestamps()
    end

    create index(:reports, [:keyword_id])
  end
end
