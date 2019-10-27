defmodule ExampleWeb.ScanController do
  use ExampleWeb, :controller

  import ExampleWeb.Authorize
  plug :user_check

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
