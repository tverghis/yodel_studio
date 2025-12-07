defmodule YodelStudio.Catalog.Video do
  use Ecto.Schema
  import Ecto.Changeset

  schema "videos" do
    field :title, :string
    field :slug, :string
    field :active, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [:title, :slug, :active])
    |> validate_required([:title, :slug, :active])
  end
end
