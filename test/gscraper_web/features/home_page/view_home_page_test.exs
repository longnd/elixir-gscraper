defmodule GscraperWeb.HomePage.ViewHomePageTest do
  use GscraperWeb.FeatureCase, async: true

  feature "view home page", %{session: session} do
    visit(session, Routes.dashboard_path(GscraperWeb.Endpoint, :index))

    assert_has(session, Query.text("Welcome to Phoenix!"))
  end
end
