defmodule Gscraper.Repo.Migrations.CreateKeywordsTable do
  use Ecto.Migration

  def change do
    create table(:keywords) do
      add :keyword, :string
      add :status, :string, size: 10
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:keywords, [:user_id])
  end
end
