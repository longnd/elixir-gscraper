defmodule GscraperWeb.UploadController do
  use GscraperWeb, :controller

  alias Gscraper.Search.Schemas.KeywordFile

  def create(conn, %{"keyword_file" => params}) do
    # Force an action on the changeset so the errors are generated
    # see: https://elixirforum.com/t/phoenix-why-not-show-changeset-errors/996/2
    changeset = %{
      KeywordFile.create_changeset(%KeywordFile{}, params)
      | action: :validate
    }

    if changeset.valid? do
      conn
      |> put_flash(
        :success,
        dgettext("keyword", "File uploaded successfully and being processed.")
      )
      |> redirect(to: Routes.dashboard_path(conn, :index))

      # TODO: parse keyword file and trigger the task to search on Google using each keyword
    else
      conn
      |> put_flash(:error, dgettext("keyword", "Invalid file, please choose another file."))
      |> put_view(GscraperWeb.DashboardView)
      |> render("index.html", changeset: changeset)
    end
  end
end
