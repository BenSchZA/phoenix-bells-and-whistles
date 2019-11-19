defmodule AppWeb.ScanController do
  use AppWeb, :controller

  import AppWeb.Authorize
  plug :user_check

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
