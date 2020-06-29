require 'rails_helper'

RSpec.describe Episode, type: :model do
  describe 'model consistency' do
    context '#validations' do
      let!(:podcast) { FactoryBot.create(:podcast) }
      let!(:episode) { FactoryBot.create(:episode, podcast_id: podcast.id, entry_id: 'abc123') }

      it { is_expected.to have_many(:interactions) }
      it { is_expected.to have_many(:users).through(:interactions)}
      it { is_expected.to belong_to(:podcast) }
      it { is_expected.to validate_presence_of(:url) }
      it { is_expected.to validate_presence_of(:entry_id) }
      it { is_expected.to validate_uniqueness_of(:entry_id) }
    end
  end
end
