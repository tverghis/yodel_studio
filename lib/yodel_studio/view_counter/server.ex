defmodule YodelStudio.ViewCounter.Server do
  use GenServer
  alias YodelStudio.Catalog

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
    :timer.send_interval(:timer.seconds(5), :stats)
    {:ok, %{total_views: 0}}
  end

  @impl true
  def handle_info(:stats, state) do
    Catalog.list_videos() |> Enum.each(fn video -> IO.puts("#{video.title}") end)
    {:noreply, state}
  end

  @impl true
  def handle_call(:get_total_views, _, %{total_views: total_views} = state) do
    {:reply, total_views, state}
  end
end
