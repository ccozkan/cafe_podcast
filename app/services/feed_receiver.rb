# frozen_string_literal: true

class FeedReceiver
  # TODO:
  # - handle error
  # - maybe add retry for few times
  # - add tests
  def self.call(url)
    response = HTTParty.get(url)
    if response.success?
      xml = response.body
      feed = Feedjira.parse(xml, parser: Feedjira::Parser::ITunesRSS)
      feed.entries.sort_by!(&:published).reverse!
      feed
    end
  end
end
