defmodule GscraperWeb.RegistrationController do
  use GscraperWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end
end
