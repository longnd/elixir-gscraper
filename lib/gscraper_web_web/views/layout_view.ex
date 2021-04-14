defmodule GscraperWebWeb.LayoutView do
  use GscraperWebWeb, :view

  def body_class_name(conn) do
    "#{module_class_name(conn)} #{action_name(conn)}"
  end

  def module_class_name(conn) do
    conn
    |> controller_module
    |> Phoenix.Naming.resource_name("Controller")
    |> String.replace("_", "-")
  end
end
