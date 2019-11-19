defmodule AppWeb.LayoutView do
  use AppWeb, :view

  def current_session(conn) do
    Plug.Conn.get_session(conn, :phauxth_session_id)
  end
end
