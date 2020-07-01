# coding: utf-8
require 'rails_helper'

RSpec.describe FeedReceiver, type: :service do

  describe 'execution' do
    it 'good podcast url' do
      url = 'https://feeds.soundcloud.com/users/soundcloud:users:340197999/sounds.rss'
      response = FeedReceiver.call(url)
      expect(response).not_to eq nil
    end

    pending "check retry request"
    pending "not podcast url"
    pending "bad url"
  end
end
