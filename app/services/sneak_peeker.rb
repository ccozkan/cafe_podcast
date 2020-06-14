# frozen_string_literal: true

class SneakPeeker
  attr_reader :url

  # TODO: use sneakpeeker as worker

  def initialize(url)
    @url = url
  end

  def call
    db_source = Podcast.find_by(url: @url)
    return db_source.episodes[-10..-1] if !db_source.nil? && !db_source.episodes.empty?

    response = web_source
    return [] if response.nil?

    response
  end

  def web_source
    feed = FeedReceiver.call(@url)
    results = []
    first_entries = feed.entries[0...10]
    first_entries.each do |con|
      results << FeedParser.call(con)
    end
    results
  end
end
