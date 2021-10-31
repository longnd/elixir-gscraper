defmodule Gscraper.Repo.Migrations.CreateKeywordsTable do
  use Ecto.Migration

  def change do
    create table(:keywords) do
      add :keyword, :string, null: false
      add :status, :string, size: 10, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:keywords, [:keyword])
    create index(:keywords, [:status])
    create index(:keywords, [:user_id])
  end
end
