class Subscription < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :contents

  validates :url, presence: true
  validates :url, uniqueness: { scope: :user,
                                     message: "user podcast is already subscribed"}
  after_create :first_time_run

  def first_time_run
    User.update_subscribed_podcasts(user, url)
  end
end
