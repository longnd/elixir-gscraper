defmodule GscraperWeb.DashboardController do
  use GscraperWeb, :controller

  alias Gscraper.Search.Schemas.KeywordFile

  def index(conn, _params) do
    changeset = KeywordFile.create_changeset(%KeywordFile{})

    render(conn, "index.html", changeset: changeset)
  end
end
