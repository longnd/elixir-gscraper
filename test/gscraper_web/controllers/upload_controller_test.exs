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

    test "renders errors when the uploaded file is not CSV", %{conn: conn} do
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

    test "renders errors when the uploaded file is empty CSV", %{conn: conn} do
      upload_file = upload_file_fixture("keyword_file/empty_file.csv")

      conn =
        conn
        |> login_user
        |> post(
          Routes.upload_path(conn, :create),
          %{keyword_file: %{file: upload_file}}
        )

      assert redirected_to(conn) == Routes.dashboard_path(conn, :index)

      conn = get(conn, Routes.dashboard_path(conn, :index))

      assert html_response(conn, 200) =~ "File is empty"
    end

    test "renders errors when the uploaded file has more than the supported limit of keywords",
         %{conn: conn} do
      upload_file = upload_file_fixture("keyword_file/exceeded_file.csv")

      conn =
        conn
        |> login_user
        |> post(
          Routes.upload_path(conn, :create),
          %{keyword_file: %{file: upload_file}}
        )

      assert redirected_to(conn) == Routes.dashboard_path(conn, :index)

      conn = get(conn, Routes.dashboard_path(conn, :index))

      assert html_response(conn, 200) =~ "The number of keywords in the file exceeds 100."
    end
  end
end
