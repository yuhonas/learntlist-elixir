defmodule LearntList.Api.Wikipedia.HttpClientTest do
  use LearntList.DataCase
  alias LearntList.Api.Wikipedia.HTTPClient

  describe "learnt_items" do
    @found_response %{
      "query" => %{"pages" => %{"12345" => %{"pageprops" => %{"wikibase_item" => "4567"}}}}
    }

    @not_found_response %{"query" => %{"pages" => %{"-1" => %{"could not find page" => ""}}}}

    test "parses the wikidata id with a sucesful response" do
      assert {:ok, "4567"} = HTTPClient.parse_wikidata_id(@found_response)
    end

    test "returns an error on a missing wikidata_id" do
      assert {:error, _} = HTTPClient.parse_wikidata_id(@not_found_response)
    end
  end
end
