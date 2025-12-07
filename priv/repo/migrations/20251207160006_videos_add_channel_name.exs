defmodule YodelStudio.Repo.Migrations.VideosAddChannelName do
  use Ecto.Migration

  def change do
    alter table(:videos) do
      add :channel_name, :string, null: false
      add :channel_id, :string, null: false
    end
  end
end
