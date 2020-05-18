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
      result = { 'url': r['feedUrl'],
                 'media_url': r['artworkUrl600'],
                 'categories': r['genres'] }
      results << result
    end
    results
  end

  def self.update_contents(user)
    user.subscriptions.each do |s|
      feed = get_feed(s.url)
      feed.entries.each do |c|
        if Content.where(entry_id: c.entry_id,
                         user_id: s.user_id).empty?
          save_contents(s, c)
        end
      end
      update_subscription(s, feed)
    end
  end


  def self.get_feed(url)
    xml = HTTParty.get(url).body
    Feedjira.parse(xml, parser: Feedjira::Parser::ITunesRSS)
  end

  def self.update_subscription(sub, feed)
    sub.last_publish_date = sub.contents.map(&:publish_date).max
    sub.name = feed.title
    sub.description = feed.description
    sub.save!
  end

  def self.save_contents(sub, con)
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
