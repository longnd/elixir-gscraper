defmodule GscraperWeb.RegistrationController do
  use GscraperWeb, :controller

  alias Gscraper.Accounts
  alias Gscraper.Accounts.User

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: Routes.dashboard_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Something went wrong! Please check the errors for more details.")
        |> render("new.html", changeset: changeset)
    end
  end
end
