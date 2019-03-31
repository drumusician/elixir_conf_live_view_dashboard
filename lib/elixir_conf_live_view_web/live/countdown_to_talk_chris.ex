defmodule ElixirConfLiveViewWeb.CountdownToTalkChris do
  use Phoenix.LiveView
  use Phoenix.HTML
  alias Timex.Interval
  alias Timex.Duration
  alias Timex.Format.Duration.Formatter 
  
  def render(assigns) do
    ~L"""
    <div class="countdown-to-talk-chris">
      <div>Chris @ElixirConfEU: <%= @time_to_talk %></div>
    </div>
    """
  end

  def mount(_session, socket) do
    if connected?(socket), do: :timer.send_interval(1000, self(), :tick)

    {:ok, put_time_to_talk(socket)}
  end

  def handle_info(:tick, socket) do
    {:noreply, put_time_to_talk(socket)}
  end

  def handle_event("nav", _path, socket) do
    {:noreply, socket}
  end

  defp put_time_to_talk(socket) do
    assign(socket, time_to_talk: time_to_talk())
  end

  defp time_to_talk do
    Interval.new(from: Timex.now, until: chris_talk_at_elixirconf_eu()) 
    |> Interval.duration(:seconds) 
    |> Duration.from_seconds 
    |> Formatter.format(:humanized)
  end

  defp chris_talk_at_elixirconf_eu do
		Timex.set(Timex.now("Europe/Prague"), [month: 4, day: 9, hour: 16, minute: 40, second: 0])
  end
end
