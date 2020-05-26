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
    # let!(:user) { FactoryBot.create(:user) }
    # let!(:sub) { FactoryBot.create(:subscription, user_id: user.id, url: 'http://feeds.soundcloud.com/users/soundcloud:users:340197999/sounds.rss') }

    # TODO:
    # fails because of sidekiq job at after_commit only create

    # context 'succesfully creates' do
    #   it 'subscriptions and its info' do
    #     expect(User.last.subscriptions.last.name).not_to eq('cool podcast')
    #     expect(user.subscriptions.last.number_of_episodes).not_to eq(nil)
    #   end
    #   it "should queue a catchup job" do
    #     expect { subscription.run_callbacks(:commit) }.to change { SubscriptionCatchUpWorker.jobs.count }.by(1)
    #   end
    #   it 'updates its contents' do
    #     expect(Content.where(user_id: user.id, subscription_id: sub.id).empty?).to eq(false)
    #   end
    # end
  end
end
