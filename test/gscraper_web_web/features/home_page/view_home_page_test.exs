defmodule GscraperWebWeb.HomePage.ViewHomePageTest do
  use GscraperWebWeb.FeatureCase

  feature "view home page", %{session: session} do
    visit(session, Routes.page_path(GscraperWebWeb.Endpoint, :index))

    assert_has(session, Query.text("Welcome to Phoenix!"))
  end
end
