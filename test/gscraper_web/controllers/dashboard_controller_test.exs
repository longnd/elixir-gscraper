defmodule GscraperWeb.DashboardControllerTest do
  use GscraperWeb.ConnCase, async: true

  describe "GET /" do
    test "renders the dashboard page", %{conn: conn} do
      conn =
        conn
        |> login_user
        |> get("/")

      assert html_response(conn, 200) =~ "Welcome to Phoenix!"
    end
  end
end
