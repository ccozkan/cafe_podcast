# frozen_string_literal: true

module UpdatePodcasts
  extend ActiveSupport::Concern

  class_methods do

    def update_subscribed_podcasts(user)
      user.subscriptions.each do |s|
        feed = get_feed(s.url)
        feed.entries.each do |c|
          if Content.where(entry_id: c.entry_id,
                           user_id: s.user_id).empty?
            save_contents(s, c)
          end
          update_subscription(s, feed)
        end
      end
    end

    def get_feed(url)
      xml = HTTParty.get(url).body
      Feedjira.parse(xml, parser: Feedjira::Parser::ITunesRSS)
    end

    def update_subscription(sub, feed)
      sub.last_publish_date = sub.contents.map(&:publish_date).max
      sub.name = feed.title
      sub.description = feed.description
      sub.save!
    end

    def save_contents(sub, con)
      content = Content.new(subscription_id: sub.id,
                            user_id: sub.user_id,
                            title: con.title,
                            duration: con.enclosure_length.to_i / 983_040 + 1,
                            url: sub.url,
                            summary: con.itunes_summary,
                            entry_id: con.entry_id,
                            keywords: con.itunes_keywords,
                            publish_date: con.published)
      content.save!
    end
  end
 end
