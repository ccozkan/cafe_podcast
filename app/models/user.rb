# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :subscriptions
  has_many :contents, through: :subscriptions

  def self.update_contents(user)
    subscriptions = Subscription.where(user_id: user.id)
    subscriptions.each do |subscription|
      feed_url = subscription.url
      xml = HTTParty.get(feed_url).body
      feed = Feedjira.parse(xml, parser: Feedjira::Parser::ITunesRSS)
      feed_class = feed.class

      contents = feed.entries
      contents.each do |content|
        title = content.title
        summary = content.itunes_summary
        entry_id = content.entry_id
        url = content.enclosure_url
        publish_date = content.published.to_date
        keywords = content.itunes_keywords

        time = (content.enclosure_length.to_i / 1024.0) / 16.0
        duration = (time / 60).ceil

        # TODO: Better alternative to duration calculation
        # enclosure_length to minutes
        # might not be most accurate
        # might not be the best choice
        # itunes provides itunes_duration
        # but how about other providers?
        # duration is an integer in db

        unless Content.where(entry_id: content.entry_id, user_id: subscription.user_id).empty?
          next
        end

        new_content = Content.new(subscription_id: subscription.id,
                                  user_id: user.id,
                                  title: title,
                                  duration: duration,
                                  url: url,
                                  summary: summary,
                                  entry_id: entry_id,
                                  publish_date: publish_date)
        new_content.save!
      end

      subscription.last_publish_date = subscription.contents.map(&:publish_date).max
      subscription.name = feed.title
      subscription.description = feed.description
      # TODO: description is needed? or provided?

      subscription.save!
    end
  end
end
