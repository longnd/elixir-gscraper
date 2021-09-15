defmodule Gscraper.Account.Passwords do
  @moduledoc false

  def hash(password), do: Argon2.hash_pwd_salt(password)

  def verify(plain_password, encrypted_password),
    do: Argon2.verify_pass(plain_password, encrypted_password)

  def no_user_verify, do: Argon2.no_user_verify()
end
