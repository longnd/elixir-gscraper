defmodule GscraperWeb.SessionControllerTest do
  use GscraperWeb.ConnCase, async: true

  describe "GET new/2" do
    test "renders the login form", %{conn: conn} do
      conn = get(conn, Routes.session_path(conn, :new))
      response = html_response(conn, 200)

      assert response =~ "Sign in"
      assert response =~ "Username"
      assert response =~ "Password"
    end

    test "redirects to the dashboard page given the user already logged in", %{conn: conn} do
      conn =
        conn
        |> login_user()
        |> get(Routes.session_path(conn, :new))

      assert redirected_to(conn) == Routes.dashboard_path(conn, :index)
      assert get_flash(conn, :info) == dgettext("auth", "You are already signed in.")
    end
  end

  describe "POST create/2" do
    test "redirects the user to the dashboard page given valid credentials", %{conn: conn} do
      user = insert(:user)
      credentials = %{"username" => user.username, "password" => user.password}

      conn = post(conn, Routes.session_path(conn, :create), user: credentials)

      assert redirected_to(conn) == Routes.dashboard_path(conn, :index)

      assert get_flash(conn, :info) ==
               dgettext("auth", "Welcome back, %{username}!", username: user.username)
    end

    test "renders the errors given invalid attributes", %{conn: conn} do
      user = insert(:user)

      conn =
        post(conn, Routes.session_path(conn, :create),
          user: %{"username" => user.username, "password" => "invalid-password"}
        )

      assert get_flash(conn, :error) == "invalid_credentials"
    end
  end
end
