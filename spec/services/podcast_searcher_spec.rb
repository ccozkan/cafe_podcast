# coding: utf-8
require 'rails_helper'

RSpec.describe PodcastSearcher, type: :service do

  describe 'search_podcasts method' do
    let(:user) { FactoryBot.create(:user)}

      it 'should find some shows' do
        p = PodcastSearcher.new('joe rogan', user)
        results = p.call
        expect(results.length).to be > 0
      end

      it 'should find more shows' do
        p = PodcastSearcher.new('reverberation radio', user)
        results = p.call
        expect(results.length).to be > 0
      end

      it 'should convert non-ascii to ascii' do
        p = PodcastSearcher.new('üç aşağı beş yukarı', user)
        results = p.call
        expect(p.query).to eq('uc asagi bes yukari')
        expect(results.length).to be > 0
      end

      it 'should remove unwnted characters' do
        p = PodcastSearcher.new('\bla"\'', user)
        expect(p.query).to eq('bla')
      end
  end
end
