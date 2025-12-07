defmodule YodelStudio.Repo.Migrations.CreateVideos do
  use Ecto.Migration

  def change do
    create table(:videos) do
      add :slug, :string, null: false
      add :active, :boolean, default: true, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
