# frozen_string_literal: true

class SneakPeeker
  attr_reader :url

  # TODO: use sneakpeeker as worker

  def initialize(url)
    @url = url
  end

  def call
    db_source = Podcast.find_by(url: @url)
    return db_source.episodes[-10..-1] || db_source.episodes.all if db_source && db_source.episodes.present?

    if web_source
      call
    else
      return []
    end
  end

  def web_source
    PodcastUpdater.call(url: @url)
  end
end
