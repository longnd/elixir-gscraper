defmodule GscraperWeb.SessionController do
  use GscraperWeb, :controller

  alias Gscraper.Accounts
  alias Gscraper.Accounts.User

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end
end
