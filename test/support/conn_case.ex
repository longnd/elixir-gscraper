defmodule GscraperWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use GscraperWeb.ConnCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  alias Ecto.Adapters.SQL.Sandbox
  alias Gscraper.Guardian.Authentication

  using do
    quote do
      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      import Gscraper.Factory
      import GscraperWeb.ConnCase
      import GscraperWeb.Gettext

      alias GscraperWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint GscraperWeb.Endpoint

      def login_user(conn, user \\ insert(:user)) do
        conn =
          conn
          |> Plug.Test.init_test_session(%{})
          |> Authentication.log_in(user)

        conn
      end
    end
  end

  setup tags do
    :ok = Sandbox.checkout(Gscraper.Repo)

    unless tags[:async] do
      Sandbox.mode(Gscraper.Repo, {:shared, self()})
    end

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
