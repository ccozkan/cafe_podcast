# coding: utf-8
require 'rails_helper'

RSpec.describe SneakPeeker, type: :service do
  describe 'execution' do
    context 'grabs from database' do
      let!(:podcast) { FactoryBot.create(:podcast) }
      let!(:episode) { FactoryBot.create(:episode, podcast_id: podcast.id, entry_id: 'abc123') }

      it 'shows with less than 10 episodes' do
        p = SneakPeeker.new(podcast.url)
        results = p.call
        expect(results.length).to be == 1
        expect(results.first).to eq episode
      end

      it 'shows with more than 10 episodes' do
        expect(podcast.episodes.first).to eq episode
        10.times do
          FactoryBot.create(:episode, podcast_id: podcast.id, entry_id: SecureRandom.hex(4), url: 'https://coolpodcast.test/' + SecureRandom.hex(4) + '.mp3')
        end

        p = SneakPeeker.new(podcast.url)
        results = p.call
        expect(results.length).to be == 10
        expect(results).not_to include(episode)
      end
    end

    context 'grabs from the web' do
      let!(:podcast) { FactoryBot.create(:podcast, url: 'http://feeds.soundcloud.com/users/soundcloud:users:340197999/sounds.rss') }

      it 'successful' do
        expect(podcast.episodes).to eq []
        p = SneakPeeker.new(podcast.url)
        results = p.call
        expect(results.present?).to be true
        expect(results.first.title).to include 'otostop'
      end

      it 'down url' do
        # TODO
        # p = SneakPeeker.new('http://not_working_url.test')
        # results = p.call
        # expect(results).to eq []
      end
    end
  end
end
