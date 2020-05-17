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

  describe 'update_contents method' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:subscription_1) { FactoryBot.create(:subscription, user_id: user.id, url: 'https://feed.podbean.com/podcast.fularsizentellik.com/feed.xml') }
    let!(:subscription_2) { FactoryBot.create(:subscription, user_id: user.id, url: "http://joeroganexp.joerogan.libsynpro.com/rss" ) }
    let!(:subscription_3) { FactoryBot.create(:subscription, user_id: user.id, url: 'https://feeds.feedburner.com/ReverberationRadio') }

    before do
      User.update_contents(user)
    end

    it 'should update contents' do
      expect(Content.where(user_id: user.id, subscription_id: subscription_1.id).empty?).to eq(false)
      expect(Content.where(user_id: user.id, subscription_id: subscription_2.id).empty?).to eq(false)
      expect(Content.where(user_id: user.id, subscription_id: subscription_3.id).empty?).to eq(false)
    end
  end

  describe 'asd' do
    it 'asd' do
      results = User.search_podcasts('joe rogan')
      results = User.search_podcasts('reverberation radio')
      expect(results.length).to be > 0
    end

  end
  #User.destroy_all
end

