defmodule ExampleWeb.ExploreLive do
  use Phoenix.LiveView
  alias ExampleWeb.ExploreView

  def render(assigns) do
    ~L"""
        <div>
          <form>
            <input name="q" placeholder="Enter a name"></input>
          </form>
        </div>
        <div>
          <img src="https://joeschmoe.io/api/v1/<%= @val %>" />
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
