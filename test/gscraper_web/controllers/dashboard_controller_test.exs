defmodule GscraperWeb.DashboardControllerTest do
  use GscraperWeb.ConnCase, async: true

  describe "GET index/2" do
    test "renders the dashboard page given the user already logged in", %{conn: conn} do
      conn =
        conn
        |> login_user
        |> get(Routes.dashboard_path(conn, :index))

      assert html_response(conn, 200) =~ "Welcome to Phoenix!"
    end

    test "redirects to the log in page given the user has not logged in", %{conn: conn} do
      conn = get(conn, Routes.dashboard_path(conn, :index))

      assert redirected_to(conn) == Routes.session_path(conn, :new)
      assert get_flash(conn, :error) == dgettext("auth", "Authentication required.")
    end
  end
end
