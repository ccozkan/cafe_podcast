require 'rails_helper'

RSpec.describe PodcastSearcher, type: :service do

  describe 'search_podcasts method' do
    let(:user) { FactoryBot.create(:user)}


      it 'should find some shows' do
        p = PodcastSearcher.new('joe rogan', user)
        results = p.call
        expect(results.length).to be > 0
      end

      it 'should fine more shows' do
        p = PodcastSearcher.new('reverberation radio', user)
        p.call
        results = p.call
        expect(results.length).to be > 0
      end
  end
end
