defmodule ElixirConfLiveViewWeb.ElixirConfTweets do
	use Phoenix.LiveView
	use Phoenix.HTML

	def render(assigns) do
		~L"""
		<div class="tweets">
		<%= for tweet <- @tweets do %>
			<div class="tweet"><%= link(tweet.tweet, to: tweet.url, target: 'blank') %></div>
			<% end %>
		</div>
		"""
	end

	def mount(_session, socket) do
    if connected?(socket) do 
			ElixirConfLiveViewWeb.Endpoint.subscribe("tweets")
		end
		
		{:ok, assign(socket, :tweets, init_tweets())}
	end

	def handle_info(%{event: "new_tweet", payload: payload}, socket) do
		{:noreply, put_tweets(socket, payload.tweet)}
	end

	defp put_tweets(socket, tweet) do
		tweets = [ tweet | Enum.take(socket.assigns.tweets, 9) ]
		assign(socket, :tweets, tweets)
	end

	def init_tweets do
		ExTwitter.search("@ElixirConfEU")
		|> Enum.take(10)
		|> Enum.map(fn(x) -> %{tweet: x.text, url: tweet_url(x)} end)
	end

  defp tweet_url(tweet) do
    "https://twitter.com/i/web/status/#{tweet.id}"
  end
end
