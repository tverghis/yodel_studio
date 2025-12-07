defmodule YodelStudio.Repo.Migrations.VideosAddTitle do
  use Ecto.Migration

  def change do
    alter table(:videos) do
      add :title, :string, null: false
    end
  end
end
