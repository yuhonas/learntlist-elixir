defmodule LearntListWeb.LearntItemController do
  use LearntListWeb, :controller

  alias LearntList.Api
  alias LearntList.Api.LearntItem

  action_fallback LearntListWeb.FallbackController

  def index(conn, _params) do
    learnt_items = Api.list_learnt_items()
    render(conn, "index.json", learnt_items: learnt_items)
  end

  def create(conn, %{"learnt_item" => learnt_item_params}) do
    with {:ok, %LearntItem{} = learnt_item} <- Api.create_learnt_item(learnt_item_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.learnt_item_path(conn, :show, learnt_item))
      |> render("show.json", learnt_item: learnt_item)
    end
  end

  def show(conn, %{"id" => id}) do
    learnt_item = Api.get_learnt_item!(id)
    render(conn, "show.json", learnt_item: learnt_item)
  end

  def update(conn, %{"id" => id, "learnt_item" => learnt_item_params}) do
    learnt_item = Api.get_learnt_item!(id)

    with {:ok, %LearntItem{} = learnt_item} <- Api.update_learnt_item(learnt_item, learnt_item_params) do
      render(conn, "show.json", learnt_item: learnt_item)
    end
  end

  def delete(conn, %{"id" => id}) do
    learnt_item = Api.get_learnt_item!(id)

    with {:ok, %LearntItem{}} <- Api.delete_learnt_item(learnt_item) do
      send_resp(conn, :no_content, "")
    end
  end
end
