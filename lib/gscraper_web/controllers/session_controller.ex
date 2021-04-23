defmodule GscraperWeb.SessionController do
  use GscraperWeb, :controller

  alias Gscraper.{Accounts, Accounts.User, Accounts.Authentication}

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => %{"username" => username, "password" => password}}) do
    Accounts.authenticate_user(username, password)
    |> login_reply(conn)
  end

  defp login_reply({:ok, user}, conn) do
    conn
    |> Authentication.log_in(user)
    |> put_flash(:info, "Welcome back, #{user.username}!")
    |> redirect(to: Routes.dashboard_path(conn, :index))
  end

  defp login_reply({:error, reason}, conn) do
    conn
    |> put_flash(:error, to_string(reason))
    |> new(%{})
  end
end
