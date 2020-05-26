class PagesController < ApplicationController
  def search
    @search = PodcastSearcher.new(pages_params['query'], current_user).call
  end

  def peek
    @peek = SneakPeeker.new(pages_params['url']).call
  end

  def about
    # TODO
  end

  def contact
    # TODO
  end

  private

  def pages_params
    params.permit(:query, :url, :authenticity_token)
  end
end
