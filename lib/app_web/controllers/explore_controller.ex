defmodule AppWeb.ExploreController do
  use AppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
