require 'rails_helper'

RSpec.describe PodcastSearcher, type: :service do
  describe 'search_podcasts method' do
    it 'should find some shows' do
      results = PodcastSearcher.call('joe rogan')
      expect(results.length).to be > 0
      results = PodcastSearcher.call('reverberation radio')
      expect(results.length).to be > 0
    end
  end
end

