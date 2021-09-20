defmodule GscraperWeb.HomePage.ViewDashboardPageTest do
  use GscraperWeb.FeatureCase, async: true

  feature "view dashboard page", %{session: session} do
    session
    |> login_user()
    |> visit(Routes.dashboard_path(Endpoint, :index))

    assert_has(session, Query.text("Welcome to Phoenix!"))
  end
end
