defmodule YodelStudioWeb.ViewCountController do
  use YodelStudioWeb, :controller

  def index(conn, _params) do
    view_count = YodelStudio.ViewCounter.Server.get_total_views()
    render(conn, :index, view_count: view_count)
  end
end
