defmodule Gscraper.Account.ErrorHandler do
  @behaviour Guardian.Plug.ErrorHandler

  use GscraperWeb, :controller

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {_type, _reason}, _opts) do
    conn
    |> put_flash(:error, dgettext("auth", "Authentication required."))
    |> redirect(to: Routes.session_path(conn, :new))
  end
end
