# frozen_string_literal: true

class PodcastSearcher
  attr_reader :query

  def initialize(query, user)
    @query = query
    @user = user
  end

  def call
    receive_results
    # results = receive_results
    # TODO:
    # DO STUFF
    # maybe some statistics idk
  end

  private

  def send_request
    url = "https://itunes.apple.com/search?term=#{@query}&entity=podcast"
    response = HTTParty.get(url,
                            headers: { 'Accept': 'application/json' },
                            format: :json)
    return nil unless response.code == 200

    response
  end

  def receive_results
    response = send_request
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
