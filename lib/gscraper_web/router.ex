defmodule GscraperWeb.Router do
  use GscraperWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  # coveralls-ignore-start
  pipeline :api do
    plug :accepts, ["json"]
  end

  # The pipeline is not logging in or authenticating the resource.
  # It is simply checking for and validating the token in the session
  # and loading the user onto the connection if found.
  pipeline :guardian do
    plug Gscraper.Guardian.Pipeline
  end

  # This pipeline is used to skip a route and redirect to the dashboard page
  # if the user already logged in.
  pipeline :skip_after_auth do
    plug GscraperWeb.Plugs.SkipAfterAuthPlug
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  # coveralls-ignore-stop

  scope "/", GscraperWeb do
    pipe_through [:browser, :guardian, :skip_after_auth]

    get "/signup", RegistrationController, :new
    post "/signup", RegistrationController, :create

    get "/login", SessionController, :new
    post "/login", SessionController, :create
  end

  scope "/", GscraperWeb do
    pipe_through [:browser, :guardian, :ensure_auth]

    get "/", DashboardController, :index

    delete "/logout", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", GscraperWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      # coveralls-ignore-start
      live_dashboard "/dashboard", metrics: GscraperWeb.Telemetry
      # coveralls-ignore-stop
    end
  end
end
