defmodule Gscraper.Account.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false

  alias Gscraper.Account.Passwords
  alias Gscraper.Account.Schemas.User
  alias Gscraper.Repo

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> find_by_id!(123)
      %User{}
      iex> find_by_id!(456)
      ** (Ecto.NoResultsError)

  """
  def find_by_id!(user_id), do: Repo.get!(User, user_id)

  @doc """
  Gets a single user by username.

  Raises `nil` if the User does not exist.

  ## Examples

      iex> find_by_username('johndoe')
      %User{}
      iex> find_by_username('nonexist')
      ** nil

  """
  def find_by_username(username), do: Repo.get_by(User, username: username)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  @doc """
  Authenticate a user with provided credentials.

  ## Examples

      iex> authenticate_user(valid_username, valid_password)
      {:ok, %User{}}

      iex> authenticate_user(valid_username, invalid_password)
      {:error, :invalid_credentials}

  """
  def authenticate_user(username, plain_password) do
    case find_by_username(username) do
      nil ->
        Passwords.no_user_verify()
        {:error, :invalid_credentials}

      user ->
        if Passwords.verify(plain_password, user.encrypted_password) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end
end
