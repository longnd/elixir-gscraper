defmodule Gscraper.Account.Queries.UserQuery do
  import Ecto.Query, warn: false

  alias Gscraper.Account.Schemas.User

  def find_by_id(user_id), do: where(User, id: ^user_id)

  def find_by_username(username), do: where(User, username: ^username)
end
