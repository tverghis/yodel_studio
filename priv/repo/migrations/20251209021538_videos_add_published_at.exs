defmodule YodelStudio.Repo.Migrations.VideosAddPublishedAt do
  use Ecto.Migration

  def change do
    alter table(:videos) do
      add :published_at, :timestamptz, null: false
    end
  end
end
