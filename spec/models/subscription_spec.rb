require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'model consistency' do
    context '#validations' do
      it { is_expected.to belong_to(:user) }
      it { is_expected.to have_many(:contents) }
      it { is_expected.to validate_presence_of(:url) }
    end
  end

  describe 'add subscription' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:sub) { FactoryBot.create(:subscription, user_id: user.id, url: 'http://feeds.soundcloud.com/users/soundcloud:users:340197999/sounds.rss') }

    context 'succesfully creates' do
      it 'subscriptions and its info' do
        expect(User.last.subscriptions.last.url).to eq(sub.url)
        expect(user.subscriptions.last.last_publish_date).not_to eq(nil)
        expect(user.subscriptions.last.media_url).not_to eq(nil)
        expect(user.subscriptions.last.name).not_to eq(nil)
      end
      it 'updates its contents' do
        expect(user.subscriptions.last.contents).not_to eq(nil)
      end
    end
  end
end
