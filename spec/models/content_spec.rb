require 'rails_helper'

RSpec.describe Content, type: :model do
  describe 'model consistency' do
    context '#validations' do
      it { is_expected.to validate_presence_of(:url) }
    end
  end

  describe 'Updating subscribed podcasts' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:subscription_1) { FactoryBot.create(:subscription, user_id: user.id, url: 'https://feed.podbean.com/podcast.fularsizentellik.com/feed.xml') }
    let!(:subscription_2) { FactoryBot.create(:subscription, user_id: user.id, url: "http://joeroganexp.joerogan.libsynpro.com/rss" ) }
    let!(:subscription_3) { FactoryBot.create(:subscription, user_id: user.id, url: 'https://feeds.feedburner.com/ReverberationRadio') }

    before do
      User.update_subscribed_podcasts(user)
    end

    it 'should update contents' do
      expect(Content.where(user_id: user.id, subscription_id: subscription_1.id).empty?).to eq(false)
      expect(Content.where(user_id: user.id, subscription_id: subscription_2.id).empty?).to eq(false)
      expect(Content.where(user_id: user.id, subscription_id: subscription_3.id).empty?).to eq(false)
    end
  end
end

