defmodule YodelStudio.ViewCounter.Server do
  use GenServer
  alias YodelStudio.Catalog
  alias YodelStudio.ViewCounter.YtClient

  require Logger

  # Public interface
  # -------------------
  def get_total_views() do
    GenServer.call(__MODULE__, :get_total_views)
  end

  # GenServer machinery
  # -------------------
  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl true
  def init(_) do
    refresh_interval = Application.fetch_env!(:yodel_studio, :counts_refresh_interval)
    :timer.send_interval(refresh_interval, :stats)

    {:ok, %{total_views: 0}, {:continue, nil}}
  end

  @impl true
  def handle_continue(_, state) do
    initial_view_counts = refresh_view_counts(state)
    {:noreply, %{state | total_views: initial_view_counts}}
  end

  @impl true
  def handle_info(:stats, state) do
    new_total_views = refresh_view_counts(state)
    {:noreply, %{state | total_views: new_total_views}}
  end

  @impl true
  def handle_call(:get_total_views, _, %{total_views: total_views} = state) do
    {:reply, total_views, state}
  end

  # Private functions
  # -------------------
  defp refresh_view_counts(%{total_views: total_views}) do
    video_ids =
      Catalog.list_videos()
      |> Enum.filter(& &1.active)
      |> Enum.map(& &1.slug)

    Logger.debug("Refreshing view counts for #{Enum.count(video_ids)} videos.")

    case YtClient.get_view_counts(video_ids) do
      {:ok, counts} -> counts
      _ -> total_views
    end
  end
end
