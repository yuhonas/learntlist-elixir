defmodule LearntListWeb.LearntItemView do
  use LearntListWeb, :view
  alias LearntListWeb.LearntItemView

  def render("index.json", %{learnt_items: learnt_items}) do
    %{data: render_many(learnt_items, LearntItemView, "learnt_item.json")}
  end

  def render("show.json", %{learnt_item: learnt_item}) do
    %{data: render_one(learnt_item, LearntItemView, "learnt_item.json")}
  end

  def render("learnt_item.json", %{learnt_item: learnt_item}) do
    %{id: learnt_item.id,
      title: learnt_item.title,
      description: learnt_item.description,
      url: learnt_item.url,
      wikidata_id: learnt_item.wikidata_id}
  end
end
