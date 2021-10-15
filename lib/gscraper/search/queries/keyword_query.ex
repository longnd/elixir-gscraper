defmodule Gscraper.Search.Queries.KeywordQuery do
  import Ecto.Query, warn: false

  alias Gscraper.Search.Schemas.Keyword

  def list_by_user(user), do: where(Keyword, user_id: ^user.id)
end