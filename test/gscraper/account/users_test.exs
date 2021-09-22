defmodule Gscraper.Account.UsersTest do
  use Gscraper.DataCase, async: true

  alias Gscraper.Account.Schemas.User
  alias Gscraper.Account.Users

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

  describe "find_by_id!/1" do
    test "returns the user given an existing user id" do
      %{id: user_id, username: username} = insert(:user)

      user_in_db = Users.find_by_id!(user_id)

      assert user_in_db.id == user_id
      assert user_in_db.username == username
    end

    test "raises Ecto.NoResultsError exception when given a non-existing user id" do
      assert_raise Ecto.NoResultsError, fn ->
        Users.find_by_id!(100)
      end
    end
  end

  describe "find_by_username/1" do
    test "returns the user given an existing username" do
      %{id: user_id, username: username} = insert(:user)

      user_in_db = Users.find_by_username(username)

      assert user_in_db.id == user_id
      assert user_in_db.username == username
    end

    test "returns nil when given a non-existing username" do
      assert Users.find_by_username("non-exist-username") == nil
    end
  end

  describe "authenticate_user/1" do
    test "returns the invalid credential error given a non-existing username and a password" do
      assert {:error, :invalid_credentials} =
               Users.authenticate_user("non-exist-username", "password")
    end

    test "returns the invalid credential error given an existing username and an invalid password" do
      insert(:user, username: "johndoe", password: "password")

      assert {:error, :invalid_credentials} = Users.authenticate_user("johndoe", "invalid-password")
    end

    test "returns the user given a valid username and invalid password" do
      %{id: user_id} = insert(:user, username: "johndoe", password: "password")

      assert {:ok, %User{id: ^user_id, username: "johndoe"}} =
               Users.authenticate_user("johndoe", "password")
    end
  end
end
