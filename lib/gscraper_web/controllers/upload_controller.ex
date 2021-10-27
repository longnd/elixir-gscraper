defmodule GscraperWeb.UploadController do
  use GscraperWeb, :controller

  alias Gscraper.Search.Schemas.KeywordFile
  alias Gscraper.Search.Searches

  def create(conn, %{"keyword_file" => params}) do
    # Force an action on the changeset so the errors are generated
    # see: https://elixirforum.com/t/phoenix-why-not-show-changeset-errors/996/2
    changeset = %{
      KeywordFile.create_changeset(%KeywordFile{}, params)
      | action: :validate
    }

    with %Ecto.Changeset{valid?: true, changes: %{file: file}} <- changeset,
         {:ok, keyword_list} <- KeywordFile.parse(file.path) do
      Searches.process_keyword_list(keyword_list, get_current_user(conn))

      redirect_to_dashboard_with_flash_message(
        conn,
        :info,
        dgettext("keyword", "File uploaded successfully and being processed.")
      )
    else
      %Ecto.Changeset{valid?: false} ->
        rerender_upload_form_with_validation_message(conn, changeset)

      {:error, :file_is_empty} ->
        redirect_to_dashboard_with_flash_message(conn, :error, dgettext("keyword", "File is empty"))

      {:error, :keyword_list_exceeded} ->
        redirect_to_dashboard_with_flash_message(
          conn,
          :error,
          dgettext("keyword", "The number of keywords in the file exceeds 100.")
        )
    end
  end

  defp redirect_to_dashboard_with_flash_message(conn, flash_type, flash_message) do
    conn
    |> put_flash(flash_type, flash_message)
    |> redirect(to: Routes.dashboard_path(conn, :index))
  end

  defp rerender_upload_form_with_validation_message(conn, changeset) do
    conn
    |> put_flash(:error, dgettext("keyword", "Invalid file, please choose another file."))
    |> put_view(GscraperWeb.DashboardView)
    |> render("index.html", changeset: changeset, keywords: get_current_user_keywords(conn))
  end

  defp get_current_user_keywords(conn),
    do: conn |> get_current_user() |> Searches.list_keywords_by_user()
end
