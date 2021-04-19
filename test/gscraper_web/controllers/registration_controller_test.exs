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
    test "redirects to the dashboard when data is valid", %{conn: conn} do
      conn = post(conn, Routes.registration_path(conn, :create), user: @create_attrs)

      assert redirected_to(conn) == Routes.dashboard_path(conn, :index)

      conn = get(conn, Routes.dashboard_path(conn, :index))
      assert html_response(conn, 200) =~ "User created successfully."
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert html_response(conn, 200) =~ "New User"
    end
  end
end
