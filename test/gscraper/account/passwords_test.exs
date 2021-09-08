defmodule Gscraper.Account.PasswordsTest do
  use Gscraper.DataCase, async: true

  alias Gscraper.Account.Passwords

  describe "hash/1" do
    test "returns the hashed password given a password" do
      password = "p@ssw0rd"

      assert Passwords.hash(password) != password
    end
  end

  describe "verify/1" do
    test "returns true given a password that matches the encrypted password" do
      password = "p@ssw0rd"
      encrypted_password = Argon2.hash_pwd_salt(password)

      assert Passwords.verify(password, encrypted_password) == true
    end

    test "returns false given a password that does NOT match the encrypted password" do
      password = "p@ssw0rd"
      encrypted_password = Argon2.hash_pwd_salt("another-password")

      assert Passwords.verify(password, encrypted_password) == false
    end
  end
end
