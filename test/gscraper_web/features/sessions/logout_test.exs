defmodule GscraperWeb.Sessions.LogoutTest do
  use GscraperWeb.FeatureCase, async: true

  @selectors %{
    button_dropdown_menu: ".app-header__user-avatar",
    logout_link: ".dropdown-menu__item a"
  }

  feature "logs the user out and redirects to the login page", %{session: session} do
    session
    |> login_user()
    |> visit(Routes.dashboard_path(GscraperWeb.Endpoint, :index))
    |> click(css(@selectors[:button_dropdown_menu]))
    |> click(css(@selectors[:logout_link]))

    assert Wallaby.Browser.current_path(session) == Routes.session_path(Endpoint, :new)
  end
end
