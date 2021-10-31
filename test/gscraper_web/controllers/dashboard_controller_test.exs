defmodule GscraperWeb.DashboardControllerTest do
  use GscraperWeb.ConnCase, async: true

  describe "GET index/2" do
    test "renders the dashboard page with the upload form and the user's keyword list
          given the user already logged in",
         %{conn: conn} do
      user1 = insert(:user)
      user2 = insert(:user)
      %{keyword: first_keyword} = insert(:keyword, user: user1)
      %{keyword: second_keyword} = insert(:keyword, user: user2)

      conn =
        conn
        |> login_user(user1)
        |> get(Routes.dashboard_path(conn, :index))

      assert html_response(conn, 200) =~ "Keyword File"
      assert html_response(conn, 200) =~ "Upload"
      assert html_response(conn, 200) =~ first_keyword
      refute html_response(conn, 200) =~ second_keyword
    end

    test "redirects to the log in page given the user has not logged in", %{conn: conn} do
      conn = get(conn, Routes.dashboard_path(conn, :index))

      assert redirected_to(conn) == Routes.session_path(conn, :new)
      assert get_flash(conn, :error) == dgettext("auth", "Authentication required.")
    end
  end
end
