class Interaction < ApplicationRecord
  belongs_to :user
  belongs_to :episode

  validates_uniqueness_of :user_id, scope: :episode_id
end
