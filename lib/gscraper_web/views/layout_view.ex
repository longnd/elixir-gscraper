defmodule GscraperWeb.LayoutView do
  use GscraperWeb, :view

  alias GscraperWeb.SharedView

  def body_class_name(conn) do
    "#{module_class_name(conn)} #{action_name(conn)}"
  end

  defp module_class_name(conn) do
    conn
    |> controller_module
    |> Phoenix.Naming.resource_name("Controller")
    |> String.replace("_", "-")
  end
end
