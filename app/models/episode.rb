class Episode < ApplicationRecord
  has_many :interactions
  has_many :users, through: :interactions
  belongs_to :podcast
  validates :url, presence: true
end
