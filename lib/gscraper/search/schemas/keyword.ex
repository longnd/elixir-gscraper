defmodule Gscraper.Search.Schemas.Keyword do
  use Ecto.Schema
  import Ecto.Changeset

  alias Gscraper.Account.Schemas.User

  schema "keywords" do
    field :keyword, :string
    field :status, Ecto.Enum, values: [:pending, :failed, :completed]

    belongs_to :user, User

    timestamps()
  end
end
