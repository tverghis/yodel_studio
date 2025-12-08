defmodule YodelStudio.Catalog.Video do
  use Ecto.Schema
  import Ecto.Changeset

  schema "videos" do
    field :title, :string
    field :slug, :string
    field :active, :boolean, default: false
    field :channel_name, :string
    field :channel_id, :string, default: "*"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [:title, :slug, :active, :channel_name, :channel_id])
    |> validate_required([:title, :slug, :active, :channel_name, :channel_id])
  end

  def youtube_url(video) do
    "https://youtube.com/watch?v=" <> video.slug
  end
end
