# frozen_string_literal: true

class PodcastSearcher
  attr_reader :query, :user

  def initialize(query, user)
    @query = query
    @user = user
  end

  def call
    unless @query.nil?
      remove_unwanted
      ascii_only
      receive_results
    else
      []
    end
    # results = receive_results
    # TODO:
    # DO STUFF
    # maybe some statistics idk
  end

  private

  def ascii_only
    @query = Ascii.process(@query)
    ascii_only_failsafe
  end

  def ascii_only_failsafe
    @query = @query.encode('ASCII', invalid: :replace, undef: :replace, replace: "_")
    # do i really need that though?
  end

  def remove_unwanted
    @query = @query.gsub('\\', '')
    @query = @query.gsub('/', '')
    @query = @query.gsub('"', ' ')
    @query = @query.gsub("'", ' ')
    # TODO:
    # make it nicer
    # do i really need that though?
  end

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
      r['genres'].try(:delete, 'Podcasts')
      result = { 'url': r['feedUrl'],
                 'media_url': r['artworkUrl600'],
                 'provider': r['artistName'],
                 'name': r['trackName'],
                 'categories': r['genres'] }
      results << result
    end
    results
  end
end
