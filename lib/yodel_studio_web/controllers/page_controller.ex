defmodule YodelStudioWeb.PageController do
  use YodelStudioWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
