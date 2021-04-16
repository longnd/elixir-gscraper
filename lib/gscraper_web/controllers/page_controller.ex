defmodule GscraperWeb.PageController do
  use GscraperWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
