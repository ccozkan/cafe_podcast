# frozen_string_literal: true

class PodcastUpdater
  def self.call(url = nil)
    if url.present?
      podcasts = []
      podcast = Podcast.find_by(url: url[:url])
      podcast = Podcast.create(url: url[:url], name: 'n/a') if podcast.nil?
      podcasts << podcast
    else
      podcasts = Podcast.all
    end

    podcasts.each do |p|
      feed = FeedReceiver.call(p.url)
      next if feed.entries && feed.entries.length == Podcast.find_by(url: p.url)
                                            .try(:number_of_episodes)

      feed.entries.each do |e|
        contents = EntryParser.call(e)
        next unless Episode.find_by(entry_id: contents[:entry_id]).nil?

        new_episode = Episode.new(contents)
        new_episode.podcast_id = p.id
        new_episode.save!
      end

      p.last_publish_date = feed.entries.map(&:published).max
      p.name = feed.title
      p.description = feed.description
      p.number_of_episodes = feed.entries.length
      p.save!
    end
  end
end
