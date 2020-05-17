class Subscription < ApplicationRecord
  belongs_to :user
  has_many :contents

  validates :url, presence: true


end
