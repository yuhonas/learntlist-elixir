defmodule LearntList.Api.Wikipedia.HTTPClient do
  use HTTPoison.Base

  @endpoint "https://en.wikipedia.org/w/api.php?action=query&prop=pageprops&format=json"

  @moduledoc """
  Wikipedia HTTP Client
  """

  @type error_map :: %{
          message: String.t(),
          line_number: integer
        }

  def set_wikidata_id(learnt_item) do
    term =
      Ecto.Changeset.get_change(learnt_item, :url)
      |> String.split("/")
      |> Enum.fetch!(-1)

    case find_wikidata_id(term) do
      {:ok, wikidata_id} ->
        Ecto.Changeset.put_change(learnt_item, :wikidata_id, wikidata_id)

      {:error, _} ->
        learnt_item
    end
  end

  def parse_wikidata_id(%{"query" => %{"pages" => %{"-1" => error}}}) do
    {:error, error}
  end

  def parse_wikidata_id(%{"query" => %{"pages" => pages}}) do
    first_page_key = Enum.fetch!(Map.keys(pages), 0)

    {:ok, get_in(pages, [first_page_key, "pageprops", "wikibase_item"])}
  end

  def find_wikidata_id(term) do
    case get(term) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        parse_wikidata_id(body)

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  def process_request_url(url) do
    @endpoint <> "&titles=" <> URI.encode(url)
  end

  def process_response_body(body) do
    body
    |> Poison.decode!()
  end
end
