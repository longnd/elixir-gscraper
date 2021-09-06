defmodule Gscraper.Account.Passwords do
  @moduledoc false

  def hash(password), do: Argon2.hash_pwd_salt(password)
end
