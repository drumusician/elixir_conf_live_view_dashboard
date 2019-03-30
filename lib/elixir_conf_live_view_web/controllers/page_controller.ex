defmodule ElixirConfLiveViewWeb.PageController do
  use ElixirConfLiveViewWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
