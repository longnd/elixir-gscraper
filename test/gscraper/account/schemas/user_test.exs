defmodule Gscraper.Accounts.UserTest do
  use Gscraper.DataCase, async: true

  alias Gscraper.Accounts.User

  describe "changeset/2" do
    test "username, password and password_confirmation are required" do
      changeset = User.changeset(%User{}, %{})

      refute changeset.valid?

      assert errors_on(changeset) == %{
               username: ["can't be blank"],
               password: ["can't be blank"],
               password_confirmation: ["can't be blank"]
             }
    end

    test "username is unique" do
      username = "devnimble"
      insert(:user, username: username)
      duplicated_user = User.changeset(%User{}, params_for(:user, username: username))

      assert {:error, changeset} = Repo.insert(duplicated_user)

      refute changeset.valid?
      assert %{username: ["has already been taken"]} = errors_on(changeset)
    end

    test "password has at least 6 characters" do
      changeset = User.changeset(%User{}, params_for(:user, password: "P@ss1"))

      refute changeset.valid?
      assert %{password: ["should be at least 6 character(s)"]} = errors_on(changeset)
    end

    test "password has a number" do
      changeset = User.changeset(%User{}, params_for(:user, password: "P@ssword"))

      refute changeset.valid?
      assert %{password: ["Password must contain a number"]} = errors_on(changeset)
    end

    test "password has an upper-case letter" do
      changeset = User.changeset(%User{}, params_for(:user, password: "p@ssw0rd"))

      refute changeset.valid?
      assert %{password: ["Password must contain an upper-case letter"]} = errors_on(changeset)
    end

    test "password has a lower-case letter" do
      changeset = User.changeset(%User{}, params_for(:user, password: "P@SSW0RD"))

      refute changeset.valid?
      assert %{password: ["Password must contain a lower-case letter"]} = errors_on(changeset)
    end

    test "password confirmation must match with password" do
      invalid_params =
        params_for(:user, password: "p@ssw0rD", password_confirmation: "another_p@ssw0rD")

      changeset = User.changeset(%User{}, invalid_params)

      refute changeset.valid?
      assert %{password_confirmation: ["does not match confirmation"]} = errors_on(changeset)
    end
  end
end
