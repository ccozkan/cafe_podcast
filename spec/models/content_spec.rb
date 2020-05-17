require 'rails_helper'

RSpec.describe Content, type: :model do
  describe 'bla' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:subscription) { FactoryBot.create(:subscription, user_id: user.id) }
    let!(:content) { FactoryBot.create(:content, user_id: user.id, subscription_id: subscription.id) }

    context '#validations' do
      it { is_expected.to validate_presence_of(:url) }
    end
  end

  describe '' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:subscription) { FactoryBot.create(:subscription, user_id: user.id, url: 'https://feed.podbean.com/podcast.fularsizentellik.com/feed.xml') }

    before do
      User.update_contents(user)
    end

    it '' do
      expect(Content.where(user_id: user.id, subscription_id: subscription.id).empty?).to eq(false)
    end
  end
  User.destroy_all
end

