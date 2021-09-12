defmodule GscraperWeb.Plugs.SkipAfterAuthPlugTest do
  use GscraperWeb.ConnCase, async: true

  alias GscraperWeb.Plugs.SkipAfterAuthPlug

  describe "init/1" do
    test "returns given options" do
      assert SkipAfterAuthPlug.init([]) == []
    end
  end

  test "renders to the dashboard page given the user already logged in", %{conn: conn} do
    conn =
      conn
      |> login_user()
      |> fetch_flash
      |> SkipAfterAuthPlug.call(%{})

    assert conn.halted
    assert redirected_to(conn) == Routes.dashboard_path(conn, :index)
    assert get_flash(conn, :info) == dgettext("auth", "You are already signed in.")
  end

  test "continues the user flow", %{conn: conn} do
    conn = SkipAfterAuthPlug.call(conn, %{})

    refute conn.halted
  end
end
