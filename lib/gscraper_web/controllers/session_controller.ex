defmodule GscraperWeb.SessionController do
  use GscraperWeb, :controller

  alias Gscraper.Account.Schemas.User
  alias Gscraper.Account.Users
  alias Gscraper.Guardian.Authentication

  def new(conn, _params) do
    changeset = Users.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => %{"username" => username, "password" => password}}) do
    username
    |> Users.authenticate_user(password)
    |> login_reply(conn)
  end

  def delete(conn, _params) do
    conn
    |> Authentication.log_out()
    |> redirect(to: Routes.session_path(conn, :new))
  end

  defp login_reply({:ok, user}, conn) do
    conn
    |> Authentication.log_in(user)
    |> put_flash(:info, dgettext("auth", "Welcome back, %{username}!", username: user.username))
    |> redirect(to: Routes.dashboard_path(conn, :index))
  end

  defp login_reply({:error, reason}, conn) do
    conn
    |> put_flash(:error, to_string(reason))
    |> new(%{})
  end
end
