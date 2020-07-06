class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :podcast

  validates_uniqueness_of :user_id, scope: :podcast_id
end
