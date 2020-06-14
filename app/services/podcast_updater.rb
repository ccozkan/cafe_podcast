# frozen_string_literal: true

class PodcastUpdater
  def self.call(url)
    podcast = Podcast.where(url: url).first_or_create
  end
  def self.call
    # TTODO podcast.call(url)
    podcasts = Podcast.all
    podcasts.each do |p|
      feed = FeedReceiver.call(p.url)
      next if feed.entries.length == Podcast.find_by(url: p.url)
                                            .try(:number_of_episodes)

      feed.entries.each do |e|
        contents = EntryParser.call(e)
        next unless Episode.find_by(entry_id: contents['entry_id']).nil?

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
#   def self.call(feed)
#     feed.entries.each do |c|
#       if user.subscriptions.find_by(id: s.id).contents
#            .find_by(entry_id: c.entry_id).nil?
#         save_contents(s, c)
#       end
#     end
#   end

#     def subs(user, specific_sub_url)
#       if specific_sub_url.empty?
#         user.subscriptions
#       else
#         user.subscriptions.where(url: specific_sub_url)
#       end
#     end

#     def update_subscribed_podcasts(user, specific_sub_url = '')
#       subs(user, specific_sub_url).each do |s|
#         feed = FeedReceiver.call(s.url)
#         next if feed.entries.length == user.subscriptions.find_by(url: s.url)
#                                            .try(:number_of_episodes)

#         feed.entries.each do |c|
#           if user.subscriptions.find_by(id: s.id).contents
#                  .find_by(entry_id: c.entry_id).nil?
#             save_contents(s, c)
#           end
#         end
#         update_subscription(s, feed)
#       end
#     end

#     def update_subscription(sub, feed)
#       sub.last_publish_date = sub.contents.map(&:publish_date).max
#       sub.name = feed.title
#       sub.description = feed.description
#       sub.number_of_episodes = feed.entries.length
#       sub.save!
#     end

#     def save_contents(sub, con)
#       content = Content.new(FeedParser.call(con))
#       content.subscription_id = sub.id
#       content.user_id = sub.user_id
#       content.save!
#     end
#   end
# end
