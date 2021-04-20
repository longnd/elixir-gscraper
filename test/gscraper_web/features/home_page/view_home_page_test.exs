defmodule GscraperWeb.HomePage.ViewHomePageTest do
  use GscraperWeb.FeatureCase

  feature "view home page", %{session: session} do
    visit(session, Routes.page_path(GscraperWeb.Endpoint, :index))

    assert_has(session, Query.text("Welcome to Phoenix!"))
  end
end
