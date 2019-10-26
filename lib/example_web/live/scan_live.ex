defmodule ExampleWeb.ScanLive do
  use Phoenix.LiveView
  alias ExampleWeb.PageView

  def render(assigns) do
    ~L"""
    <div class="sandbox">
      <div>
          <form phx-submit="scan">
              <input name="repo" class="input" type="text" placeholder="e.g. Uniswap/uniswap-frontend"/>
          </form>
          <table class="table is-striped is-hoverable is-fullwidth">
              <thead>
                  <tr>
                      <%= for {col, title} <- @cols do %>
                      <th><%= title %></th>
                      <% end %>
                  </tr>
              </thead>
              <tbody>
                  <%= for row <- @results do %>
                      <tr>
                      <%= for {col, _title} <- @cols do %>
                          <td><%= Map.get(row, col) %></td>
                      <% end %>
                      </tr>
                  <% end %>
              </tbody>
          </table>
      </div>
    </div>
    """
  end

  def mount(_session, socket) do
    cols = [
      {:address, "Address"},
      {:url, "URL"}
    ]

    {:ok, assign(socket, results: [], cols: cols)}
  end

  defmodule GitHubAPI do
    def get_urls(content) do
      content["items"]
      |> Enum.map(fn item -> item["url"] end)
    end

    def get_download_urls(urls) do
      IO.inspect urls
      Enum.map urls, fn(url) ->
        case HTTPoison.get(url) do
          {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
            Poison.decode!(body)
            |> get_in(["download_url"])
          {:ok, _} ->
            ""
          {:error, %HTTPoison.Error{reason: reason}} ->
            IO.inspect reason
            reason
        end
      end
    end

    def regex_search(urls, query) do
      IO.inspect urls
      Enum.flat_map urls, fn(url) ->
        case HTTPoison.get(url) do
          {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
            Regex.scan(~r/0x([a-zA-Z0-9]*)/, body)
            |> Enum.map(&hd/1)
          {:ok, _} ->
            []
          {:error, %HTTPoison.Error{reason: reason}} ->
            IO.inspect reason
            reason
        end
      end
    end
  end

  def search_repo(repo, query) do
    url = "https://api.github.com/search/code?q=#{query}+in:file+repo:#{repo}"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Poison.decode!(body)
        |> GitHubAPI.get_urls
        |> GitHubAPI.get_download_urls
        |> GitHubAPI.regex_search(query)
        |> Enum.uniq
        |> Enum.filter(fn address -> String.length(address) >= 40 end)
        |> Enum.map(fn address -> %{address: address, url: ""} end)
      {:ok, _} ->
        []
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
        reason
    end
  end

  def handle_event("scan", %{"repo" => repo}, socket) do #%{"repo" => repo}
    query = "0x"
    repo = case repo do
      "" -> "Uniswap/uniswap-frontend"
      _  -> repo
    end
    results = search_repo(repo, query)
    IO.inspect results
    {:noreply, assign(socket, :results, results)}
  end
end
