defmodule Gscraper.Account.UsersTest do
  use Gscraper.DataCase, async: true

  alias Gscraper.Account.Users
  alias Gscraper.Account.Schema.User

  describe "create_user/1" do
    test "creates a user given valid data" do
      valid_params = params_for(:user, password: "P@ssw0rd")

      assert {:ok, %User{} = user} = Users.create_user(valid_params)
      assert user.username == valid_params[:username]
      assert user.encrypted_password !== "P@ssw0rd"
    end

    test "returns error changeset given invalid data" do
      invalid_params = params_for(:user, password: nil)

      assert {:error, %Ecto.Changeset{}} = Users.create_user(invalid_params)
    end
  end
end
