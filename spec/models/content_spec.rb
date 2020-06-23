# require 'rails_helper'

# User.destroy_all
# Subscription.destroy_all

# RSpec.describe Episode, type: :model do
#   describe 'model consistency' do
#     context '#validations' do
#       it { is_expected.to validate_presence_of(:url) }
#     end
#   end

#   describe 'Updating subscribed podcasts' do
#     let!(:user) { FactoryBot.create(:user) }

#     let!(:subscription_1) { FactoryBot.create(:subscription, user_id: user.id, url: 'https://feed.podbean.com/podcast.fularsizentellik.com/feed.xml') }
#     let!(:subscription_2) { FactoryBot.create(:subscription, user_id: user.id, url: "http://joeroganexp.joerogan.libsynpro.com/rss" ) }
#     let!(:subscription_3) { FactoryBot.create(:subscription, user_id: user.id, url: 'https://feeds.feedburner.com/ReverberationRadio') }
#     let!(:subscription_4) { FactoryBot.create(:subscription, user_id: user.id, url: 'http://feeds.soundcloud.com/users/soundcloud:users:340197999/sounds.rss') }

#     it 'should update contents' do
#       User.update_subscribed_podcasts(user)
#       expect(Content.where(user_id: user.id, subscription_id: subscription_1.id).empty?).to eq(false)
#       expect(Content.where(user_id: user.id, subscription_id: subscription_2.id).empty?).to eq(false)
#       expect(Content.where(user_id: user.id, subscription_id: subscription_3.id).empty?).to eq(false)
#       expect(Content.where(user_id: user.id, subscription_id: subscription_4.id).empty?).to eq(false)
#     end

#     it 'should not update if the entry length is not changed' do
#       # TODO
#       # idea behind is true but this is not really checking anything
#       # maybe check
#       # first_run = User.update_subscribed_podcasts(user, specific_sub_url=subscription_4.url)
#       User.update_subscribed_podcasts(user, specific_sub_url=subscription_4.url)
#       first_updated_at = User.find_by(id: user.id).subscriptions.find_by(url: subscription_4.url).updated_at
#       sleep 2
#       User.update_subscribed_podcasts(user, specific_sub_url=subscription_4.url)
#       last_updated_at = User.find_by(id: user.id).reload.subscriptions.find_by(url: subscription_4.url).updated_at
#       expect(first_updated_at).to eq(last_updated_at)
#     end
#   end
# end

