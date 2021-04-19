defmodule Gscraper.AccountsTest do
  use Gscraper.DataCase

  alias Gscraper.Accounts

  describe "users" do
    alias Gscraper.Accounts.User

    test "create_user/1 with valid data creates a user" do
      valid_params = params_for(:user, password: "P@ssw0rd")
      assert {:ok, %User{} = user} = Accounts.create_user(valid_params)
      assert user.username == valid_params[:username]
      assert user.encrypted_password !== "P@ssw0rd"
    end

    test "create_user/1 with invalid data returns error changeset" do
      invalid_params = params_for(:user, password: nil)
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(invalid_params)
    end
  end
end
