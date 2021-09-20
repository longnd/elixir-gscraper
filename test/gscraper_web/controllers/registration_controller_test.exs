defmodule GscraperWeb.RegistrationControllerTest do
  use GscraperWeb.ConnCase, async: true

  describe "GET new/2" do
    test "renders the registration form", %{conn: conn} do
      conn = get(conn, Routes.registration_path(conn, :new))
      response = html_response(conn, 200)

      assert response =~ "Sign up"
      assert response =~ "Already had an account"
      assert response =~ "Sign in"
    end
  end

  describe "POST create/2" do
    test "redirects the user to the dashboard page given valid attributes", %{conn: conn} do
      create_params = %{username: username} = params_for(:user)
      conn = post(conn, Routes.registration_path(conn, :create), user: create_params)

      assert redirected_to(conn) == Routes.dashboard_path(conn, :index)
      assert get_flash(conn, :info) == dgettext("auth", "Welcome, %{username}!", username: username)
    end

    test "renders the errors given invalid attributes", %{conn: conn} do
      invalid_params = params_for(:user, password: nil)
      conn = post(conn, Routes.registration_path(conn, :create), user: invalid_params)

      assert get_flash(conn, :error) ==
               dgettext("error", "Something went wrong! Please check the errors for more details.")
    end
  end
end
