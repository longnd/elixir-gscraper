defmodule Gscraper.Accounts.Guardian do
  use Guardian, otp_app: :gscraper

  alias Gscraper.Accounts

  @doc """
    Used to encode the User into the token
  """
  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  @doc """
    Used to rehydrate the User from the claims.
  """
  def resource_from_claims{%{"sub" => id}} do
    user = Accounts.get_user!(id)
    {:ok, user}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end
end
