defmodule GscraperWeb.Plugs.SkipAfterAuth do
  @moduledoc """
    To skip a route and redirect to the dashboard page if the user is
    already authenticated.
  """

  import Plug.Conn
  import Phoenix.Controller
  import GscraperWeb.Gettext

  alias Gscraper.Guardian.Authentication
  alias GscraperWeb.Router.Helpers, as: Routes

  def init(default), do: default

  def call(conn, _) do
    if Authentication.get_current_user(conn) do
      conn
      |> put_flash(:info, dgettext("auth", "You are already signed in."))
      |> redirect(to: Routes.dashboard_path(conn, :index))
      |> halt()
    else
      conn
    end
  end
end
