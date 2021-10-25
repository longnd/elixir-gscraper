defmodule Gscraper.Search.Schemas.KeywordFileTest do
  use Gscraper.DataCase, async: true

  import GscraperWeb.FixtureHelpers

  alias Gscraper.Search.Schemas.KeywordFile

  describe "create_changeset/1" do
    test "returns valid changeset given the file exists in the params" do
      attrs = %{file: upload_file_fixture("keyword_file/valid_file.csv")}

      changeset = KeywordFile.create_changeset(%KeywordFile{}, attrs)

      assert changeset.valid? == true
      assert changeset.changes == attrs
    end

    test "returns invalid changeset given the file does NOT exist in the params" do
      changeset = KeywordFile.create_changeset(%KeywordFile{}, %{file: nil})

      assert changeset.valid? == false
      assert errors_on(changeset) == %{file: ["can't be blank"]}
    end

    test "returns invalid changeset given the file is NOT CSV" do
      attrs = %{file: upload_file_fixture("keyword_file/invalid_file.jpg")}

      changeset = KeywordFile.create_changeset(%KeywordFile{}, attrs)

      assert changeset.valid? == false
      assert errors_on(changeset) == %{file: ["is not a CSV file"]}
    end
  end

  describe "parse/1" do
    test "returns the keyword list given valid keyword file" do
      %{path: file_path} = upload_file_fixture("keyword_file/valid_file.csv")

      assert {:ok, ["strawberry", "pineapple", "pomelo"]} = KeywordFile.parse(file_path)
    end

    test "returns a `:file_is_empty` error given an empty keyword file" do
      %{path: file_path} = upload_file_fixture("keyword_file/empty_file.csv")

      assert {:error, :file_is_empty} = KeywordFile.parse(file_path)
    end

    test "returns a `:keyword_list_exceeded` error given a keyword file exceeds the number of supported keywords" do
      %{path: file_path} = upload_file_fixture("keyword_file/exceeded_file.csv")

      assert {:error, :keyword_list_exceeded} = KeywordFile.parse(file_path)
    end
  end
end
