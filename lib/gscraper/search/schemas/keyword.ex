defmodule Gscraper.Search.Schemas.Keyword do
  use Ecto.Schema
  import Ecto.Changeset

  alias Gscraper.Account.Schemas.{Report, User}

  schema "keywords" do
    field :keyword, :string
    field :status, Ecto.Enum, values: [:pending, :failed, :completed]

    belongs_to :user, User
    has_one :report, Report

    timestamps()
  end

  def create_changeset(keyword \\ %__MODULE__{}, attrs) do
    keyword
    |> cast(attrs, [:keyword, :user_id])
    |> put_change(:status, :pending)
    |> validate_required([:keyword, :user_id])
    |> assoc_constraint(:user)
  end
end
