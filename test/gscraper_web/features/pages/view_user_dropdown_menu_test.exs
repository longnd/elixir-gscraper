defmodule GscraperWeb.Pages.ViewUserDropdownMenuTest do
  use GscraperWeb.FeatureCase, async: true

  @selectors %{
    button_dropdown_menu: ".app-header__user-avatar",
    dropdown_menu: ".user-dropdown-menu"
  }

  feature "view user's dropdown menu", %{session: session} do
    user = insert(:user)

    session
    |> login_user(user)
    |> visit(Routes.dashboard_path(GscraperWeb.Endpoint, :index))
    |> assert_has(css(@selectors[:button_dropdown_menu]))
    |> click(css(@selectors[:button_dropdown_menu]))
    |> assert_has(css(@selectors[:dropdown_menu]))
    |> assert_has(css(@selectors[:dropdown_menu], text: user.username))
    |> assert_has(css(@selectors[:dropdown_menu], text: dgettext("auth", "Logout")))
  end
end
