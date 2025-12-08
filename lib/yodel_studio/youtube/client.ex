defmodule YodelStudio.YouTube.Client do
  require Logger

  def get_view_counts(video_ids) do
    case Req.get(construct_url(video_ids, "statistics", "items/statistics/viewCount")) do
      {:ok, resp} ->
        handle_view_counts_resp(resp)

      {:error, exception} ->
        Logger.error(Exception.message(exception))
        {:error, :api_error}
    end
  end

  def get_video_details(video_ids) do
    part = "snippet"
    fields = "items(snippet(channelId,channelTitle,title))"

    # TODO: can probably DRY this response handling code
    case Req.get(construct_url(video_ids, part, fields)) do
      {:ok, resp} ->
        handle_video_details_resp(resp)

      {:error, exception} ->
        Logger.error(Exception.message(exception))
        {:error, :api_error}
    end
  end

  defp construct_url(video_ids, part, fields) do
    ids = "id=" <> Enum.join(video_ids, ",")
    part = "&part=" <> part
    fields = "&fields=" <> fields
    key = "&key=" <> Application.fetch_env!(:yodel_studio, :yt_api_key)

    "https://www.googleapis.com/youtube/v3/videos?" <> ids <> part <> fields <> key
  end

  # View count response handlers
  # ----------------------------
  defp handle_view_counts_resp(%{status: status, body: body}) when div(status, 100) == 2 do
    total_counts = aggregate_counts(body["items"])
    Logger.debug("Fetched counts: #{total_counts}")
    {:ok, total_counts}
  end

  defp handle_view_counts_resp(%{status: status}) do
    Logger.error("YouTube API returned non-success status #{status}")
    {:error, :api_error}
  end

  defp aggregate_counts(api_response) do
    api_response
    |> Enum.map(fn item ->
      item["statistics"]["viewCount"]
      |> String.to_integer()
    end)
    |> Enum.sum()
  end

  # Video details response handlers
  # -------------------------------
  defp handle_video_details_resp(%{status: status, body: body}) when div(status, 100) == 2 do
    details = body["items"] |> Enum.map(fn item -> item["snippet"] end)
    {:ok, details}
  end

  defp handle_video_details_resp(%{status: status}) do
    Logger.error("YouTube API returned non-success status #{status}")
    {:error, :api_error}
  end
end
