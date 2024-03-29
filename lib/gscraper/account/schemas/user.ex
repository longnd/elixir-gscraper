defmodule Gscraper.Account.Schemas.User do
  use Ecto.Schema
  import Ecto.Changeset
  import GscraperWeb.Gettext

  alias Gscraper.Account.Passwords
  alias Gscraper.Search.Schemas.Keyword

  schema "users" do
    field :username, :string
    field :encrypted_password, :string

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    has_many :keywords, Keyword

    timestamps()
  end

  @fields ~w(username password password_confirmation)a

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> unique_constraint(:username)
    |> validate_password()
    |> hash_password()
  end

  defp validate_password(changeset) do
    changeset
    |> validate_length(:password, min: 6)
    |> validate_format(:password, ~r/[0-9]+/,
      message: dgettext("auth", "Password must contain a number")
    )
    |> validate_format(:password, ~r/[A-Z]+/,
      message: dgettext("auth", "Password must contain an upper-case letter")
    )
    |> validate_format(:password, ~r/[a-z]+/,
      message: dgettext("auth", "Password must contain a lower-case letter")
    )
    |> validate_confirmation(:password)
  end

  defp hash_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, encrypted_password: Passwords.hash(password))
  end

  defp hash_password(changeset), do: changeset
end
