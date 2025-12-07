defmodule YodelStudio.ViewCounter.Server do
  use GenServer
  alias YodelStudio.Catalog

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl true
  def init(_) do
    :timer.send_interval(:timer.seconds(5), :stats)
    {:ok, nil}
  end

  @impl true
  def handle_info(:stats, state) do
    Catalog.list_videos() |> Enum.each(fn video -> IO.puts("#{video.title}") end)
    {:noreply, state}
  end
end
