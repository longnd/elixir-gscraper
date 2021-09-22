defmodule GscraperWeb.RegistrationController do
  use GscraperWeb, :controller

  alias Gscraper.Account.Schemas.User
  alias Gscraper.Account.Users
  alias Gscraper.Guardian.Authentication

  def new(conn, _params) do
    changeset = Users.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Users.create_user(user_params) do
      {:ok, user} ->
        conn
        |> Authentication.log_in(user)
        |> put_flash(:info, dgettext("auth", "Welcome, %{username}!", username: user.username))
        |> redirect(to: Routes.dashboard_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(
          :error,
          dgettext("error", "Something went wrong! Please check the errors for more details.")
        )
        |> render("new.html", changeset: changeset)
    end
  end
end
