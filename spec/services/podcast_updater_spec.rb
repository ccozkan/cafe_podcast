# coding: utf-8
require 'rails_helper'

Podcast.destroy_all
RSpec.describe PodcastUpdater, type: :service do
  describe 'update podcasts' do
    let!(:podcast) { FactoryBot.create(:podcast, url: 'http://feeds.soundcloud.com/users/soundcloud:users:340197999/sounds.rss') }

    before do
      PodcastUpdater.call
    end

    it 'retrieves episodes at first run' do
      expect(podcast.episodes.count).to be > 0
    end

    it 'retrieves episodes at first run' do
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
end
