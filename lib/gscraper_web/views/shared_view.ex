defmodule GscraperWeb.SharedView do
  use GscraperWeb, :view

  alias Gscraper.Guardian.Authentication

  def current_user(conn), do: Authentication.get_current_user(conn)

  def current_user_username(conn) do
    case current_user(conn) do
      nil -> nil
      _ -> current_user(conn).username
    end
  end

  def current_user_initial_character_username(conn) do
    case current_user_username(conn) do
      nil -> nil
      _ -> String.at(current_user_username(conn), 0)
    end
  end
end
