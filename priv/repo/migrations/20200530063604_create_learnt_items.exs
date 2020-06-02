defmodule LearntList.Repo.Migrations.CreateLearntItems do
  use Ecto.Migration

  def change do
    create table(:learnt_items) do
      add :title, :string, null: false
      add :description, :string
      add :url, :string, null: false
      add :wikidata_id, :string

      timestamps()
    end

    create unique_index(:learnt_items, :url)
    create unique_index(:learnt_items, :wikidata_id)
  end
end
