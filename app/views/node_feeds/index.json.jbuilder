json.array!(@node_feeds) do |node_feed|
  json.extract! node_feed, :id
  json.url node_feed_url(node_feed, format: :json)
end
