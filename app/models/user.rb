# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :subscriptions
  has_many :contents, through: :subscriptions

  include UpdatePodcasts

  def self.search_podcasts(query)
    url = "https://itunes.apple.com/search?term=#{query}&entity=podcast"
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
end
