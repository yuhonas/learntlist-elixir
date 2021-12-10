# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     LearntList.Repo.insert!(%LearntList.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias LearntList.Api

defmodule LearntList.Seeds do
  @doc """
  Seed a CSV formatted row into the DB
  """
  def seed_from_csv(result) do
    case result do
      {:ok, row} -> Api.create_learnt_item(row)
      {:error, error} -> IO.puts(:stderr, error)
    end
  end
end

# FIXME: Use a path relative to the running script
File.stream!("priv/repo/seeds.csv")
|> Stream.drop(1)
|> CSV.decode(headers: [:title, :url, :inserted_at, :wikidata_id, :description])
|> Enum.each(&LearntList.Seeds.seed_from_csv/1)
