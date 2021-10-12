defmodule GscraperWeb.UploadControllerTest do
  use GscraperWeb.ConnCase, async: true

  import GscraperWeb.FixtureHelpers

  describe "create/2" do
    test "redirects to the dashboard page when the uploaded file is valid", %{conn: conn} do
      upload_file = upload_file_fixture("keyword_file/valid_file.csv")

      conn =
        conn
        |> login_user
        |> post(
          Routes.upload_path(conn, :create),
          %{keyword_file: %{file: upload_file}}
        )

      assert redirected_to(conn) == Routes.dashboard_path(conn, :index)

      conn = get(conn, Routes.dashboard_path(conn, :index))

      assert html_response(conn, 200) =~ "File uploaded successfully and being processed."
    end

    test "renders errors when the uploaded file is invalid", %{conn: conn} do
      upload_file = upload_file_fixture("keyword_file/invalid_file.jpg")

      conn =
        conn
        |> login_user
        |> post(
          Routes.upload_path(conn, :create),
          %{keyword_file: %{file: upload_file}}
        )

      assert html_response(conn, 200) =~ "Invalid file, please choose another file."
      assert html_response(conn, 200) =~ "is not a CSV file"
    end
  end
end
