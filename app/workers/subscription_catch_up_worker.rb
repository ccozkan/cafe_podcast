class SubscriptionCatchUpWorker
  include Sidekiq::Worker
#  sidekiq_options retry: false

  def perform(user_id, url)
    user = User.find_by(id: user_id)
    User.update_subscribed_podcasts(user, url)
  end
end
