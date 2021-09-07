defmodule Gscraper.Guardian.Authentication do
  @moduledoc """
  Implementation module for Guardian and functions for authentication.
  """
  use Guardian, otp_app: :gscraper

  alias Gscraper.Account.Users

  @doc """
    Used to encode the User into the token
  """
  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  @doc """
    Used to rehydrate the User from the claims.
  """
  def resource_from_claims(%{"sub" => id}) do
    user = Users.find_by_id!(id)
    {:ok, user}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end

  @doc """
    Call the Guardian's sign_in function to sign in the user which:
    - adds the current user to the connection in the Guardian-configured location
    - adds the token to the session to indicate the account has logged in
  """
  def log_in(conn, user) do
    __MODULE__.Plug.sign_in(conn, user)
  end

  @doc """
    Get the current logged in user
  """
  def get_current_user(conn) do
    __MODULE__.Plug.current_resource(conn)
  end
end
