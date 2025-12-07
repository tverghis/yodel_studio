defmodule YodelStudio.CatalogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `YodelStudio.Catalog` context.
  """

  @doc """
  Generate a video.
  """
  def video_fixture(attrs \\ %{}) do
    {:ok, video} =
      attrs
      |> Enum.into(%{
        active: true,
        slug: "some slug"
      })
      |> YodelStudio.Catalog.create_video()

    video
  end
end
