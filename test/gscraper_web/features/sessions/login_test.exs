defmodule GscraperWeb.Sessions.LoginTest do
  use GscraperWeb.FeatureCase, async: true

  @selectors %{
    username_input: "#user_username",
    password_input: "#user_password",
    button_login: ".btn--primary"
  }

  feature "logs the user in and redirects to dashboard page given valid credentials",
          %{session: session} do
    %{username: username, password: password} = insert(:user)

    session
    |> visit(Routes.session_path(Endpoint, :new))
    |> fill_in(css(@selectors[:username_input]), with: username)
    |> fill_in(css(@selectors[:password_input]), with: password)
    |> click(css(@selectors[:button_login]))
    |> assert_has(Query.text(dgettext("auth", "Welcome back, %{username}!", username: username)))

    assert Wallaby.Browser.current_path(session) == Routes.dashboard_path(Endpoint, :index)
  end

  feature "keeps the user on the sign in page and shows error message given invalid credentials",
          %{session: session} do
    %{username: username} = insert(:user)

    session
    |> visit(Routes.session_path(Endpoint, :new))
    |> fill_in(css(@selectors[:username_input]), with: username)
    |> fill_in(css(@selectors[:password_input]), with: "invalid-password")
    |> click(css(@selectors[:button_login]))
    |> assert_has(Query.text("invalid_credentials"))

    assert Wallaby.Browser.current_path(session) == Routes.session_path(Endpoint, :new)
  end
end
