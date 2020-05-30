defmodule LearntList.Repo.Migrations.CreateLearntItems do
  use Ecto.Migration

  def change do
    create table(:learnt_items) do
      add :title, :string
      add :description, :string
      add :url, :string
      add :wikidata_id, :string

      timestamps()
    end

  end
end
