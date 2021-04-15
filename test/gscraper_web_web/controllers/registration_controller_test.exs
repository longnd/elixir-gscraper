defmodule GscraperWebWeb.RegistrationControllerTest do
  use GscraperWebWeb.ConnCase

  test "new/2 renders the new template", %{conn: conn} do
    conn = get(conn, Routes.registration_path(conn, :new))

    assert html_response(conn, 200) =~ gettext("Sign up")
  end
end
