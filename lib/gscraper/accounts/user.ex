defmodule Gscraper.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import GscraperWeb.Gettext

  alias Gscraper.Accounts.Password

  schema "users" do
    field :username, :string
    field :encrypted_password, :string

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @fields ~w(username password password_confirmation)a

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> unique_constraint(:username)
    |> validate_password
  end

  def validate_password(changeset) do
    changeset
    |> validate_length(:password, min: 6)
    |> validate_format(:password, ~r/[0-9]+/, message: dgettext("auth", "Password must contain a number"))
    |> validate_format(:password, ~r/[A-Z]+/, message: dgettext("auth", "Password must contain an upper-case letter"))
    |> validate_format(:password, ~r/[a-z]+/, message: dgettext("auth", "Password must contain a lower-case letter"))
    |> validate_confirmation(:password)
    |> put_password_hash
  end

  defp put_password_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, encrypted_password: Password.hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
