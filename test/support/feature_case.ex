defmodule GscraperWebWeb.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.Feature

      import GscraperWeb.Factory

      alias GscraperWebWeb.Router.Helpers, as: Routes
    end
  end
end
