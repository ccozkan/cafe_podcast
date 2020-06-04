class Subscription < ApplicationRecord
  belongs_to :user
  has_many :contents, dependent: :destroy

  validates :url, presence: true
  validates :url, uniqueness: { scope: :user,
                                     message: "user podcast is already subscribed"}
  after_commit :first_time_catch_up, on: :create

  extend FriendlyId
  friendly_id :name, use: :slugged

  def first_time_catch_up
    user = User.find_by(id: user_id)
    User.update_subscribed_podcasts(user, url)
    #SubscriptionCatchUpWorker.perform_async(user.id, url)
  end
end
