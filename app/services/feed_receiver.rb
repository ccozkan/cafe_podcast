# frozen_string_literal: true

class FeedReceiver
  def self.call(url)
    xml = HTTParty.get(url).body
    feed = Feedjira.parse(xml, parser: Feedjira::Parser::ITunesRSS)
    feed.entries.sort_by!(&:published)
    feed
  end
end
