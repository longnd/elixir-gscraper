defmodule GscraperWeb.DashboardController do
  use GscraperWeb, :controller

  alias Gscraper.Search.Schemas.KeywordFile
  alias Gscraper.Search.Searches

  def index(conn, _params) do
    changeset = KeywordFile.create_changeset(%KeywordFile{})

    keywords =
      conn
      |> get_current_user()
      |> Searches.list_keywords_by_user()

    render(conn, "index.html", changeset: changeset, keywords: keywords)
  end
end
