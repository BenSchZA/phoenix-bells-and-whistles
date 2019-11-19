defmodule AppWeb.HelloController do
  use AppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def scan(conn, %{"messenger" => messenger}) do
    render(conn, "show.html", messenger: messenger)
  end
end
