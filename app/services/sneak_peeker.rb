# frozen_string_literal: true

class SneakPeeker
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def call
    get_feed
    response = parse_feed
    if response.nil?
      return []
    else
      return response
    end
  end

  def get_feed
    xml = HTTParty.get(@url).body
    Feedjira.parse(xml, parser: Feedjira::Parser::ITunesRSS)
  end

  def parse_feed
    feed = get_feed
    results = []
    first_entries = feed.entries[0...10]
    first_entries.each do |con|
      result = { title: con.title,
                 duration: con.enclosure_length.to_i / 983_040 + 1,
                 summary: con.itunes_summary,
                 keywords: con.itunes_keywords,
                 publish_date: con.published }
      results << result
    end
    results
  end
end
