defmodule AppWeb.ExploreLive do
  use Phoenix.LiveView
  alias AppWeb.ExploreView

  def render(assigns) do
    ~L"""
      <div>

      </div>
    """
  end

  def mount(_session, socket) do
    {:ok, assign(socket, val: "random")}
  end

  def handle_event("update-avatar", %{"q" => name}, socket) do
    case name do
      "" -> {:noreply, assign(socket, :val, "random")}
      _  -> {:noreply, assign(socket, :val, name)}
    end
  end
end
