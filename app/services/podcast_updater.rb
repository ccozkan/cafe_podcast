# frozen_string_literal: true

class PodcastUpdater
  def self.call(specific_url = nil)
    if specific_url.present?
      podcasts = []
      podcasts << Podcast.create(url: specific_url, name: 'n/a')
    else
      podcasts = Podcast.all
    end

    podcasts.each do |p|
      feed = FeedReceiver.call(p.url)
      next if feed.entries.length == Podcast.find_by(url: p.url)
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
