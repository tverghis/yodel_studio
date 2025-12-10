defmodule YodelStudioWeb.VideoController do
  use YodelStudioWeb, :controller

  alias Ecto.Changeset
  alias YodelStudio.YouTube
  alias YodelStudio.Catalog
  alias YodelStudio.Catalog.Video

  def index(conn, _params) do
    videos =
      Catalog.list_videos()
      |> Enum.sort_by(fn video -> video.channel_name end)

    render(conn, :index, videos: videos)
  end

  def new(conn, _params) do
    changeset = Catalog.change_video(%Video{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"video" => video_params}) do
    user = conn.assigns.current_scope.user
    %{"slug" => slug} = video_params
    slug = String.trim(slug)

    case YouTube.Client.get_video_details([slug]) do
      {:ok, [detail]} ->
        {:ok, published_at, _} = DateTime.from_iso8601(detail["publishedAt"])

        video_params =
          Map.merge(video_params, %{
            "slug" => slug,
            "channel_id" => detail["channelId"],
            "channel_name" => detail["channelTitle"],
            "title" => detail["title"],
            "published_at" => published_at
          })

        create_video(conn, video_params, user)

      _ ->
        changeset =
          %Video{}
          |> Video.changeset(video_params)
          |> Changeset.add_error(:slug, "Failed to fetch video details.")
          |> Map.put(:action, :validate)

        conn
        |> render(:new, changeset: changeset)
    end
  end

  defp create_video(conn, video_params, user) do
    case Catalog.create_video(video_params, user) do
      {:ok, video} ->
        IO.puts("created video successfully")
        IO.inspect(video)

        conn
        |> put_flash(:info, "Video created successfully.")
        |> redirect(to: ~p"/videos/#{video}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    video = Catalog.get_video!(id)
    render(conn, :show, video: video)
  end

  def edit(conn, %{"id" => id}) do
    video = Catalog.get_video!(id)
    changeset = Catalog.change_video(video)
    render(conn, :edit, video: video, changeset: changeset)
  end

  def update(conn, %{"id" => id, "video" => video_params}) do
    video = Catalog.get_video!(id)

    case Catalog.update_video(video, video_params) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Video updated successfully.")
        |> redirect(to: ~p"/videos/#{video}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, video: video, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    video = Catalog.get_video!(id)
    {:ok, _video} = Catalog.delete_video(video)

    conn
    |> put_flash(:info, "Video deleted successfully.")
    |> redirect(to: ~p"/videos")
  end
end
