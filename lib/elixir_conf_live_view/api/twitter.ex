defmodule ElixirConfLiveView.Api.Twitter do
  use GenServer

  def start_link([]) do
    GenServer.start_link(__MODULE__, [])
  end
  
  def init(_) do
    {:ok, start_stream()}
  end
  
	def start_stream do
		spawn(fn ->
      stream = ExTwitter.stream_filter([track: "@ElixirConfEU"], :infinity)
      for tweet <- stream do
				ElixirConfLiveViewWeb.Endpoint.broadcast("tweets", "new_tweet", %{tweet: tweet.text, url: tweet_url(tweet)}) 
      end
    end)
	end

  defp tweet_url(tweet) do
    "https://twitter.com/i/web/status/#{tweet.id}"
  end
end
