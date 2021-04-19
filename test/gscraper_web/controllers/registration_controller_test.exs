defmodule GscraperWeb.RegistrationControllerTest do
  use GscraperWeb.ConnCase

  describe "GET /signup" do
    test "renders the registration form", %{conn: conn} do
      conn = get(conn, Routes.registration_path(conn, :new))
      response = html_response(conn, 200)

      assert response =~ "Sign up"
      assert response =~ "Already had an account"
      assert response =~ "Sign in"
    end
  end

  describe "POST /signup" do
    test "given valid attributes, it redirects to the dashboard", %{conn: conn} do
      conn = post(conn, Routes.registration_path(conn, :create), user: params_for(:user))

      assert redirected_to(conn) == Routes.dashboard_path(conn, :index)

      conn = get(conn, Routes.dashboard_path(conn, :index))
      assert html_response(conn, 200) =~ "User created successfully."
    end

    test "given invalid attributes, it renders errors", %{conn: conn} do
      invalid_params = params_for(:user, password: nil)
      conn = post(conn, Routes.registration_path(conn, :create), user: invalid_params)
      assert html_response(conn, 200) =~ "Something went wrong! Please check the errors for more details"
    end
  end
end
