defmodule YodelStudio.Repo.Migrations.VideosAddUniqueConstraint do
  use Ecto.Migration

  def change do
    create unique_index(:videos, [:slug])
  end
end
