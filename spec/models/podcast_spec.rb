# coding: utf-8
require 'rails_helper'
RSpec.describe Podcast, type: :model do
  describe 'model consistency' do
    context '#validations' do
      it { is_expected.to have_many(:episodes) }
      it { is_expected.to have_many(:users).through(:subscriptions)}
    end

    context 're-slugging' do
      let(:podcast) { FactoryBot.create(:podcast, name: 'el-podcasto') }
      it 'when name changes' do
        expect(podcast.slug).to eq 'el-podcasto'
        podcast.name = 'nuevo'
        podcast.save

        expect(podcast.slug).to eq 'nuevo'
      end
    end
  end

  describe 'Successfull podcast ' do
    let(:current_user) { FactoryBot.build(:user)}
    let(:podcast) { FactoryBot.create(:podcast, original_adder_id: current_user.id, url: 'http://feeds.soundcloud.com/users/soundcloud:users:340197999/sounds.rss') }
    let(:podcast_2) { FactoryBot.create(:podcast, url: 'https://feeds.feedburner.com/ReverberationRadio') }

    before {
      current_user.confirm
      podcast
      podcast_2
    }

    context 'creation relationship' do
      it 'w/ added_by creates new sub' do
        expect(Subscription.find_by(podcast_id: podcast.id)).not_to eq nil
        expect(Subscription.find_by(podcast_id: podcast.id).user_id).to eq podcast.original_adder_id
      end
      it 'w/out added by doesnot create new sub' do
        expect(Subscription.find_by(podcast_id: podcast_2.id)).to eq nil
      end
      it 'check slug candidate' do
        FactoryBot.create(:podcast, name: 'ASD ÇÖzxc')
        expect(Podcast.last.slug).to eq 'asd-zxc'
      end
    end

    context 'update podcast' do
      it 'update first time' do
        PodcastUpdater.call
        expect(Episode.where(podcast_id: podcast.id).length).to be > 0
      end
    end
  end
end
