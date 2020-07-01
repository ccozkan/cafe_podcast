# coding: utf-8
require 'rails_helper'

RSpec.describe PodcastUpdater, type: :service do
  before do
    Podcast.destroy_all
  end

  describe 'update podcasts' do
    let!(:podcast) { FactoryBot.create(:podcast, url: 'http://feeds.soundcloud.com/users/soundcloud:users:340197999/sounds.rss') }

    before do
      PodcastUpdater.call
    end

    it 'retrieves episodes at first run' do
      expect(podcast.episodes.count).to be > 0
    end

    it 'retrieves podcast info at first run' do
      expect(podcast.reload.name).to eq 'Üç Aşağı Beş Yukarı'
    end

    it 'updates episodes' do
      podcast.episodes.last.destroy
      podcast.number_of_episodes = 1
      podcast.save

      expect(podcast.episodes.count).to be == 1
      PodcastUpdater.call
      expect(podcast.reload.episodes.count).to be == 2
    end

    it 'updates podcast info' do
      podcast.name = 'foo'
      podcast.number_of_episodes = 1
      podcast.save

      PodcastUpdater.call
      expect(podcast.reload.name).to eq 'Üç Aşağı Beş Yukarı'
    end
  end

  describe 'update specific podcast' do
    it 'successful' do
      url = 'http://feeds.soundcloud.com/users/soundcloud:users:340197999/sounds.rss'
      PodcastUpdater.call(url: url)
      expect(Podcast.find_by(url: url)).not_to eq nil
    end

    it 'bad url' do
      # TODO
      url = 'https://feed.coolpodcast.test'
    end
  end
end
