defmodule Gscraper.Repo.Migrations.CreateReportsTable do
  use Ecto.Migration

  def change do
    create table(:reports) do
      add :keyword_id, references(:keywords, on_delete: :delete_all)
      add :ads_link_count, :integer
      add :top_ads_link_count, :integer
      add :top_ads_link_list, {:array, :string}
      add :organic_link_count, :integer
      add :organic_link_list, {:array, :string}
      add :link_count, :integer
      add :html_content, :text

      timestamps()
    end

    create index(:reports, [:keyword_id])
  end
end
