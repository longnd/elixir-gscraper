defmodule GscraperWeb.RegistrationControllerTest do
  use GscraperWeb.ConnCase

  describe "GET /signup" do
    test "renders the registration page", %{conn: conn} do
      conn = get(conn, Routes.registration_path(conn, :new))
      response = html_response(conn, 200)

      assert response =~ "Sign up"
      assert response =~ "Already had an account"
      assert response =~ "Sign in"
    end
  end
end
