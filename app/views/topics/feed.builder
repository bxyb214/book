xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "swiftist.org"
    xml.link root_url
    xml.description "swiftist.org"
    for topic in @topics
      xml.item do
        xml.title topic.title
        xml.description topic.body
        xml.pubDate topic.created_at
      end
    end
  end
end
