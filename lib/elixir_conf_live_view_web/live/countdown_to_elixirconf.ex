defmodule ElixirConfLiveViewWeb.CountdownToElixirconf do
  use Phoenix.LiveView
  use Phoenix.HTML
  alias Timex.{ Interval, Duration, Format.Duration.Formatter }
  
  def render(assigns) do
    ~L"""
    <div class="countdown-to-elixirconf">
      <h3><%= @time_to_conf %></h3>
    </div>
    """
  end

  def mount(_session, socket) do
    if connected?(socket), do: :timer.send_interval(1000, self(), :tick)

    {:ok, put_time_to_conf(socket)}
  end

  def handle_info(:tick, socket) do
    {:noreply, put_time_to_conf(socket)}
  end

  defp put_time_to_conf(socket) do
    assign(socket, time_to_conf: time_to_conf())
  end

  defp time_to_conf do
    cond do
      Timex.now > time_to_elixirconf() ->
        "It's Alive!! Alive!"
      true ->
        Interval.new(from: Timex.now, until: time_to_elixirconf()) 
        |> Interval.duration(:seconds) 
        |> Duration.from_seconds 
        |> Formatter.format(:humanized)
    end
  end

  defp time_to_elixirconf do
    Timex.set(Timex.now("Europe/Prague"), [month: 4, day: 8, hour: 9, minute: 0, second: 0])
  end
end
