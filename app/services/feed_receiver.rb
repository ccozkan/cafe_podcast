# frozen_string_literal: true

class FeedReceiver
  def self.call(url)
    begin
      response = HTTParty.get(url)
      if response.success?
        xml = response.body
        feed = Feedjira.parse(xml, parser: Feedjira::Parser::ITunesRSS)
        feed.entries.sort_by!(&:published).reverse!
        feed
      end
    rescue
      'some error'
    end
  end
end
