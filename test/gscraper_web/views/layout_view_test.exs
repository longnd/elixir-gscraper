defmodule GscraperWeb.LayoutViewTest do
  use GscraperWeb.ConnCase, async: true

  alias GscraperWeb.LayoutView

  describe "body_class_name/1" do
    test "returns the CSS classes for the document body" do
      conn = get(build_conn(), Routes.registration_path(GscraperWeb.Endpoint, :new))

      assert LayoutView.body_class_name(conn) == "registration new"
    end
  end
end
