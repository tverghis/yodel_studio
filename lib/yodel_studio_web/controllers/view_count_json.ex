defmodule YodelStudioWeb.ViewCountJSON do
  def index(%{view_count: view_count}) do
    %{data: %{view_count: view_count}}
  end
end
