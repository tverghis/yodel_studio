defmodule YodelStudio.Catalog.Video do
  use Ecto.Schema
  import Ecto.Changeset

  schema "videos" do
    field :slug, :string
    field :active, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [:slug, :active])
    |> validate_required([:slug, :active])
  end
end
