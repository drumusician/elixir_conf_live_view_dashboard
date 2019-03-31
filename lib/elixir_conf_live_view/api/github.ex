defmodule ElixirConfLiveView.Api.Github do
  alias Tentacat.Repositories 
  use GenServer

  @timeout 10_000

  def start_link([]) do
    GenServer.start_link(__MODULE__, [])
  end
  
  def init(_) do
    {:ok, statistics(), @timeout}
  end
  
  def handle_info(:timeout, _) do
    new_stats = statistics()
    ElixirConfLiveViewWeb.Endpoint.broadcast("github", "new_stats", new_stats) 
    {:noreply, new_stats, @timeout}
  end

  defp statistics do
    token = Application.get_env(:elixir_conf_live_view, :github_api_key)
    client = Tentacat.Client.new(%{access_token: token})

    { 200, _, response} = Repositories.repo_get(client, "phoenixframework", "phoenix_live_view")
		
    stats = response.body 

		%{
			stars: stats["stargazers_count"],
			issues: stats["open_issues_count"],
			forks: stats["forks_count"],
			releases: stats["releases"]
		}
  end
end
