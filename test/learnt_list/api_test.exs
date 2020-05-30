defmodule LearntList.ApiTest do
  use LearntList.DataCase

  alias LearntList.Api

  describe "learnt_items" do
    alias LearntList.Api.LearntItem

    @valid_attrs %{description: "some description", title: "some title", url: "some url", wikidata_id: "some wikidata_id"}
    @update_attrs %{description: "some updated description", title: "some updated title", url: "some updated url", wikidata_id: "some updated wikidata_id"}
    @invalid_attrs %{description: nil, title: nil, url: nil, wikidata_id: nil}

    def learnt_item_fixture(attrs \\ %{}) do
      {:ok, learnt_item} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Api.create_learnt_item()

      learnt_item
    end

    test "list_learnt_items/0 returns all learnt_items" do
      learnt_item = learnt_item_fixture()
      assert Api.list_learnt_items() == [learnt_item]
    end

    test "get_learnt_item!/1 returns the learnt_item with given id" do
      learnt_item = learnt_item_fixture()
      assert Api.get_learnt_item!(learnt_item.id) == learnt_item
    end

    test "create_learnt_item/1 with valid data creates a learnt_item" do
      assert {:ok, %LearntItem{} = learnt_item} = Api.create_learnt_item(@valid_attrs)
      assert learnt_item.description == "some description"
      assert learnt_item.title == "some title"
      assert learnt_item.url == "some url"
      assert learnt_item.wikidata_id == "some wikidata_id"
    end

    test "create_learnt_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Api.create_learnt_item(@invalid_attrs)
    end

    test "update_learnt_item/2 with valid data updates the learnt_item" do
      learnt_item = learnt_item_fixture()
      assert {:ok, %LearntItem{} = learnt_item} = Api.update_learnt_item(learnt_item, @update_attrs)
      assert learnt_item.description == "some updated description"
      assert learnt_item.title == "some updated title"
      assert learnt_item.url == "some updated url"
      assert learnt_item.wikidata_id == "some updated wikidata_id"
    end

    test "update_learnt_item/2 with invalid data returns error changeset" do
      learnt_item = learnt_item_fixture()
      assert {:error, %Ecto.Changeset{}} = Api.update_learnt_item(learnt_item, @invalid_attrs)
      assert learnt_item == Api.get_learnt_item!(learnt_item.id)
    end

    test "delete_learnt_item/1 deletes the learnt_item" do
      learnt_item = learnt_item_fixture()
      assert {:ok, %LearntItem{}} = Api.delete_learnt_item(learnt_item)
      assert_raise Ecto.NoResultsError, fn -> Api.get_learnt_item!(learnt_item.id) end
    end

    test "change_learnt_item/1 returns a learnt_item changeset" do
      learnt_item = learnt_item_fixture()
      assert %Ecto.Changeset{} = Api.change_learnt_item(learnt_item)
    end
  end
end
