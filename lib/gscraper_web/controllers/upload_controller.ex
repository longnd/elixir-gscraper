defmodule GscraperWeb.UploadController do
  use GscraperWeb, :controller

  import Ecto.Changeset, only: [get_field: 2]

  alias Gscraper.Search.Schemas.KeywordFile
  alias Gscraper.Search.Searches

  def create(conn, %{"keyword_file" => params}) do
    # Force an action on the changeset so the errors are generated
    # see: https://elixirforum.com/t/phoenix-why-not-show-changeset-errors/996/2
    changeset = %{
      KeywordFile.create_changeset(%KeywordFile{}, params)
      | action: :validate
    }

    if changeset.valid? do
      file = get_field(changeset, :file)
      handle_valid_uploaded_file(conn, file)
    else
      keywords = conn |> get_current_user() |> Searches.list_keywords_by_user()

      conn
      |> put_flash(:error, dgettext("keyword", "Invalid file, please choose another file."))
      |> put_view(GscraperWeb.DashboardView)
      |> render("index.html", changeset: changeset, keywords: keywords)
    end
  end

  defp handle_valid_uploaded_file(conn, file) do
    case Searches.parse_keyword_form_file(file.path) do
      {:ok, keyword_list} ->
        Searches.process_keyword_list(keyword_list, get_current_user(conn))

        conn
        |> put_flash(
          :info,
          dgettext("keyword", "File uploaded successfully and being processed.")
        )
        |> redirect(to: Routes.dashboard_path(conn, :index))

      {:error, :file_is_empty} ->
        conn
        |> put_flash(:error, dgettext("keyword", "File is empty"))
        |> redirect(to: Routes.dashboard_path(conn, :index))

      {:error, :keyword_list_exceeded} ->
        conn
        |> put_flash(
          :error,
          dgettext("keyword", "The number of keywords in the file exceeds 100.")
        )
        |> redirect(to: Routes.dashboard_path(conn, :index))
    end
  end
end
