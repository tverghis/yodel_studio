defmodule YodelStudioWeb.VideoControllerTest do
  use YodelStudioWeb.ConnCase

  import YodelStudio.CatalogFixtures

  @create_attrs %{active: true, slug: "some slug"}
  @update_attrs %{active: false, slug: "some updated slug"}
  @invalid_attrs %{active: nil, slug: nil}

  describe "index" do
    test "lists all videos", %{conn: conn} do
      conn = get(conn, ~p"/videos")
      assert html_response(conn, 200) =~ "Listing Videos"
    end
  end

  describe "new video" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/videos/new")
      assert html_response(conn, 200) =~ "New Video"
    end
  end

  describe "create video" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/videos", video: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/videos/#{id}"

      conn = get(conn, ~p"/videos/#{id}")
      assert html_response(conn, 200) =~ "Video #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/videos", video: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Video"
    end
  end

  describe "edit video" do
    setup [:create_video]

    test "renders form for editing chosen video", %{conn: conn, video: video} do
      conn = get(conn, ~p"/videos/#{video}/edit")
      assert html_response(conn, 200) =~ "Edit Video"
    end
  end

  describe "update video" do
    setup [:create_video]

    test "redirects when data is valid", %{conn: conn, video: video} do
      conn = put(conn, ~p"/videos/#{video}", video: @update_attrs)
      assert redirected_to(conn) == ~p"/videos/#{video}"

      conn = get(conn, ~p"/videos/#{video}")
      assert html_response(conn, 200) =~ "some updated slug"
    end

    test "renders errors when data is invalid", %{conn: conn, video: video} do
      conn = put(conn, ~p"/videos/#{video}", video: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Video"
    end
  end

  describe "delete video" do
    setup [:create_video]

    test "deletes chosen video", %{conn: conn, video: video} do
      conn = delete(conn, ~p"/videos/#{video}")
      assert redirected_to(conn) == ~p"/videos"

      assert_error_sent 404, fn ->
        get(conn, ~p"/videos/#{video}")
      end
    end
  end

  defp create_video(_) do
    video = video_fixture()

    %{video: video}
  end
end
