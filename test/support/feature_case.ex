defmodule GscraperWeb.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.Feature

      import Gscraper.Factory

      alias GscraperWeb.Router.Helpers, as: Routes
    end
  end
end
