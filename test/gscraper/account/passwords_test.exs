defmodule Gscraper.Account.PasswordsTest do
  use Gscraper.DataCase, async: true

  alias Gscraper.Account.Passwords

  describe "hash/1" do
    test "returns the hashed password given a password" do
      password = "random-string"

      assert Passwords.hash(password) != password
    end
  end
end
