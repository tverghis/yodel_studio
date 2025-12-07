defmodule YodelStudio.CatalogTest do
  use YodelStudio.DataCase

  alias YodelStudio.Catalog

  describe "videos" do
    alias YodelStudio.Catalog.Video

    import YodelStudio.CatalogFixtures

    @invalid_attrs %{active: nil, slug: nil}

    test "list_videos/0 returns all videos" do
      video = video_fixture()
      assert Catalog.list_videos() == [video]
    end

    test "get_video!/1 returns the video with given id" do
      video = video_fixture()
      assert Catalog.get_video!(video.id) == video
    end

    test "create_video/1 with valid data creates a video" do
      valid_attrs = %{active: true, slug: "some slug"}

      assert {:ok, %Video{} = video} = Catalog.create_video(valid_attrs)
      assert video.active == true
      assert video.slug == "some slug"
    end

    test "create_video/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_video(@invalid_attrs)
    end

    test "update_video/2 with valid data updates the video" do
      video = video_fixture()
      update_attrs = %{active: false, slug: "some updated slug"}

      assert {:ok, %Video{} = video} = Catalog.update_video(video, update_attrs)
      assert video.active == false
      assert video.slug == "some updated slug"
    end

    test "update_video/2 with invalid data returns error changeset" do
      video = video_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_video(video, @invalid_attrs)
      assert video == Catalog.get_video!(video.id)
    end

    test "delete_video/1 deletes the video" do
      video = video_fixture()
      assert {:ok, %Video{}} = Catalog.delete_video(video)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_video!(video.id) end
    end

    test "change_video/1 returns a video changeset" do
      video = video_fixture()
      assert %Ecto.Changeset{} = Catalog.change_video(video)
    end
  end
end
