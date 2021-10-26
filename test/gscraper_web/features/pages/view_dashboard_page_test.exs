defmodule GscraperWeb.Pages.ViewDashboardPageTest do
  use GscraperWeb.FeatureCase, async: true

  feature "view dashboard page", %{session: session} do
    session
    |> login_user()
    |> visit(Routes.dashboard_path(Endpoint, :index))

    assert_has(session, Query.text("Keyword File"))
    assert_has(session, Query.text("Upload"))
  end
end
