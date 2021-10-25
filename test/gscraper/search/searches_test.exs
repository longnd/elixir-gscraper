defmodule Gscraper.Search.SearchesTest do
  use Gscraper.DataCase, async: true

  alias Gscraper.Search.Schemas.Keyword
  alias Gscraper.Search.Searches

  describe "list_keywords_by_user/1" do
    test "returns all keywords" do
      user1 = insert(:user)
      user2 = insert(:user)

      %{keyword: first_keyword} = insert(:keyword, user: user1)
      _keyword2 = insert(:keyword, user: user2)

      assert [%Keyword{keyword: ^first_keyword}] = Searches.list_keywords_by_user(user1)
    end
  end

  describe "create_keyword/1" do
    test "create a keyword given valid params" do
      %{id: user_id} = insert(:user)
      valid_attributes = %{keyword: "some keyword", user_id: user_id}

      assert {:ok, %Keyword{} = keyword} = Searches.create_keyword(valid_attributes)
      assert keyword.keyword == "some keyword"
      assert keyword.user_id == user_id
    end

    test "returns an error changeset given invalid params" do
      invalid_attributes = %{keyword: nil, user_id: nil}

      assert {:error, %Ecto.Changeset{}} = Searches.create_keyword(invalid_attributes)
    end
  end

  describe "process_keyword_list/2" do
    test "save the keywords into database given a list of keyword and a user who uploaded the list" do
      user = insert(:user)
      keyword_list = ["first keyword", "second keyword"]

      Searches.process_keyword_list(keyword_list, user)

      assert Keyword |> Repo.all() |> length() == 2
    end
  end
end
