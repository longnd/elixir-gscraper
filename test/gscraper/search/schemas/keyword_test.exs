defmodule Gscraper.Search.Schemas.KeywordTest do
  use Gscraper.DataCase, async: true

  alias Gscraper.Search.Schemas.Keyword

  describe "changeset/2" do
    test "returns valid changeset given valid params" do
      %{id: user_id} = insert(:user)
      params = params_for(:keyword, user_id: user_id)

      changeset = Keyword.create_changeset(params)

      assert changeset.valid? == true
      assert changeset.changes == params
    end

    test "returns invalid changeset given blank params" do
      changeset = Keyword.create_changeset(%{keyword: "", user_id: ""})

      assert changeset.valid? == false

      assert errors_on(changeset) == %{
               keyword: [dgettext("errors", "can't be blank")],
               user_id: [dgettext("errors", "can't be blank")]
             }
    end

    test "returns invalid changeset given user does NOT exist" do
      params = params_for(:keyword, user: nil, user_id: 0)

      changeset = Keyword.create_changeset(params)

      assert {:error, changeset} = Repo.insert(changeset)
      assert errors_on(changeset) == %{user: ["does not exist"]}
    end
  end
end
