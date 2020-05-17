# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :subscriptions
  has_many :contents, through: :subscriptions

  def self.search_podcasts(terms)
    url = "https://itunes.apple.com/search?term=#{terms}&entity=podcast"
    response = HTTParty.get(url,
                            headers: { 'Accept': 'application/json' },
                            format: :json)

    return nil unless response.code == 200

    results = []
    response['results'].each do |r|
      result = {}
      result['url'] = r['feedUrl']
      result['media_url'] = r['artworkUrl600']
      result['categories'] = r['genres']
      results << result
    end
    results
  end

  def self.update_contents(user)
    subscriptions = Subscription.where(user_id: user.id)
    subscriptions.each do |s|
      feed_url = s.url
      xml = HTTParty.get(feed_url).body
      feed = Feedjira.parse(xml, parser: Feedjira::Parser::ITunesRSS)

      contents = feed.entries
      contents.each do |c|
        title = c.title
        summary = c.itunes_summary
        entry_id = c.entry_id
        url = c.enclosure_url
        publish_date = c.published.to_date
        keywords = c.itunes_keywords

        time = (c.enclosure_length.to_i / 1024.0) / 16.0
        duration = (time / 60).ceil

        unless Content.where(entry_id: c.entry_id,
                             user_id: s.user_id).empty?
          next
        end

        new_content = Content.new(subscription_id: s.id,
                                  user_id: user.id,
                                  title: title,
                                  duration: duration,
                                  url: url,
                                  summary: summary,
                                  entry_id: entry_id,
                                  keywords: keywords,
                                  publish_date: publish_date)
        new_content.save!
      end

      s.last_publish_date = s.contents.map(&:publish_date).max
      s.name = feed.title
      s.description = feed.description
      s.save!
    end
  end
end
