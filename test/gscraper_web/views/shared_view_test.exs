defmodule GscraperWeb.SharedViewTest do
  use GscraperWeb.ConnCase, async: true

  alias GscraperWeb.SharedView

  describe "current_user/1" do
    test "returns the current user object from the connection given it exists", %{conn: conn} do
      conn = Plug.Conn.put_private(conn, :guardian_default_resource, :mock_user)

      assert SharedView.current_user(conn) == :mock_user
    end

    test "returns nil given no current user object in the connection", %{conn: conn} do
      assert SharedView.current_user(conn) == nil
    end
  end

  describe "current_user_username/1" do
    test "returns the username given the conn with current user", %{conn: conn} do
      user = build(:user)
      conn = Plug.Conn.put_private(conn, :guardian_default_resource, user)

      assert SharedView.current_user_username(conn) == user.username
    end

    test "returns nil given NO current user object in the conn", %{conn: conn} do
      assert SharedView.current_user_username(conn) == nil
    end
  end

  describe "current_user_initial_character_username/1" do
    test "returns the first character of username given the conn with current user", %{conn: conn} do
      user = build(:user, username: "johndoe")
      conn = Plug.Conn.put_private(conn, :guardian_default_resource, user)

      assert SharedView.current_user_initial_character_username(conn) == "j"
    end

    test "returns nil given NO current user object in the conn", %{conn: conn} do
      assert SharedView.current_user_initial_character_username(conn) == nil
    end
  end
end
