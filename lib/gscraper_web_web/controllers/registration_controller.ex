defmodule GscraperWebWeb.RegistrationController do
  use GscraperWebWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end
end
