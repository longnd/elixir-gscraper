defmodule GscraperWeb.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.Feature

      import Gscraper.Factory
      import GscraperWeb.Gettext

      import Wallaby.Query

      alias GscraperWeb.Endpoint
      alias GscraperWeb.Router.Helpers, as: Routes

      @moduletag :feature_test

      def login_user(session, user \\ insert(:user)) do
        session
        |> visit(Routes.session_path(GscraperWeb.Endpoint, :new))
        |> fill_in(Wallaby.Query.text_field("user_username"), with: user.username)
        |> fill_in(Wallaby.Query.text_field("user_password"), with: user.password)
        |> click(Wallaby.Query.button("Login"))
      end
    end
  end
end
