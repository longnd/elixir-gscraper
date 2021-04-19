defmodule Gscraper.Accounts.UserTest do
  use Gscraper.DataCase

  alias Gscraper.Accounts.User

  describe "changeset" do
    test "username, password and password_confirmation are required" do
      changeset = %User{} |> User.changeset(%{})

      refute changeset.valid?
      assert %{username: ["can't be blank"]} = errors_on(changeset)
      assert %{password: ["can't be blank"]} = errors_on(changeset)
      assert %{password_confirmation: ["can't be blank"]} = errors_on(changeset)
    end

    test "username is unique" do
      username = "devnimble"
      insert(:user, username: username)
      duplicated_user = %User{} |> User.changeset(params_for(:user, username: username))

      assert {:error, changeset} = Repo.insert(duplicated_user)

      refute changeset.valid?
      assert %{username: ["has already been taken"]} = errors_on(changeset)
    end

    test "password has at least 6 characters" do
      changeset = %User{} |> User.changeset(params_for(:user, password: "P@ss1"))

      refute changeset.valid?
      assert %{password: ["should be at least 6 character(s)"]} = errors_on(changeset)
    end

    test "password has a number" do
      changeset = %User{} |> User.changeset(params_for(:user, password: "P@ssword"))

      refute changeset.valid?
      assert %{password: ["Password must contain a number"]} = errors_on(changeset)
    end

    test "password has an upper-case letter" do
      changeset = %User{} |> User.changeset(params_for(:user, password: "p@ssw0rd"))

      refute changeset.valid?
      assert %{password: ["Password must contain an upper-case letter"]} = errors_on(changeset)
    end

    test "password has a lower-case letter" do
      changeset = %User{} |> User.changeset(params_for(:user, password: "P@SSW0RD"))

      refute changeset.valid?
      assert %{password: ["Password must contain a lower-case letter"]} = errors_on(changeset)
    end

    test "password confirmation must match with password" do
      invalid_params =
        params_for(:user, password: "p@ssw0rD", password_confirmation: "another_p@ssw0rD")

      changeset = %User{} |> User.changeset(invalid_params)

      refute changeset.valid?
      assert %{password_confirmation: ["does not match confirmation"]} = errors_on(changeset)
    end
  end
end
