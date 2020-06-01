defmodule LearntListWeb.LearntItemControllerTest do
  use LearntListWeb.ConnCase

  alias LearntList.Api
  alias LearntList.Api.LearntItem

  @create_attrs %{
    description: "some description",
    title: "some title",
    url: "some url",
    wikidata_id: "some wikidata_id"
  }
  @update_attrs %{
    description: "some updated description",
    title: "some updated title",
    url: "some updated url",
    wikidata_id: "some updated wikidata_id"
  }
  @invalid_attrs %{description: nil, title: nil, url: nil, wikidata_id: nil}

  def fixture(:learnt_item) do
    {:ok, learnt_item} = Api.create_learnt_item(@create_attrs)
    learnt_item
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all learnt_items", %{conn: conn} do
      conn = get(conn, Routes.learnt_item_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end

    test "has the correct CORS response headers", %{conn: conn} do
      conn = get(conn, Routes.learnt_item_path(conn, :index))

      assert Enum.into(conn.resp_headers, %{}) |>
        Map.fetch("access-control-allow-origin") == {:ok, "*" }
    end
  end

  describe "create learnt_item" do
    test "renders learnt_item when data is valid", %{conn: conn} do
      conn = post(conn, Routes.learnt_item_path(conn, :create), learnt_item: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.learnt_item_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some description",
               "title" => "some title",
               "url" => "some url",
               "wikidata_id" => "some wikidata_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.learnt_item_path(conn, :create), learnt_item: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update learnt_item" do
    setup [:create_learnt_item]

    test "renders learnt_item when data is valid", %{conn: conn, learnt_item: %LearntItem{id: id} = learnt_item} do
      conn = put(conn, Routes.learnt_item_path(conn, :update, learnt_item), learnt_item: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.learnt_item_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some updated description",
               "title" => "some updated title",
               "url" => "some updated url",
               "wikidata_id" => "some updated wikidata_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, learnt_item: learnt_item} do
      conn = put(conn, Routes.learnt_item_path(conn, :update, learnt_item), learnt_item: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete learnt_item" do
    setup [:create_learnt_item]

    test "deletes chosen learnt_item", %{conn: conn, learnt_item: learnt_item} do
      conn = delete(conn, Routes.learnt_item_path(conn, :delete, learnt_item))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.learnt_item_path(conn, :show, learnt_item))
      end
    end
  end

  defp create_learnt_item(_) do
    learnt_item = fixture(:learnt_item)
    %{learnt_item: learnt_item}
  end
end
