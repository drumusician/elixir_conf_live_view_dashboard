defmodule ElixirConfLiveViewWeb.PhoenixLiveViewGithub do
  use Phoenix.LiveView
  use Phoenix.HTML
  alias Tentacat.Repositories 
  
  def render(assigns) do
    ~L"""
    <div class="d-flex justify-content-center">
      <h4><%= live_render(@socket, ElixirConfLiveViewWeb.CountdownToTalkChris) %></h4>
    </div>
    <div class="live_view_stats">
      <div class="stat">
        <span class="heading">Stars</span>
        <span class="value"><%= @statistics.stars %></span>
      </div>
      <div class="stat">
        <span class="heading">Issues</span>
        <span class="value"><%= @statistics.issues %></span>
      </div>
      <div class="stat">
        <span class="heading">Forked</span>
        <span class="value"><%= @statistics.forks %></span>
      </div>
    </div>
    """
  end

  def mount(_session, socket) do
    if connected?(socket), do: ElixirConfLiveViewWeb.Endpoint.subscribe("github")

    {:ok, init_statistics(socket)}
  end

	def handle_info(%{event: "new_stats", payload: payload}, socket) do
    {:noreply, assign(socket, :statistics, payload)}
	end

  defp init_statistics(socket) do
    assign(socket, statistics: statistics())
  end

  def statistics do
		%{
			stars: 0,
			issues: 0,
			forks: 0
		}
  end

  defp released?(n) when n == 0 do 
		"sentiment_very_dissatisfied"
  end

	defp released?(n) do
		"sentiment_very_dissatisfied"
	end
end

