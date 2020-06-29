class Episode < ApplicationRecord
  has_many :interactions
  has_many :users, through: :interactions
  belongs_to :podcast

  validates_presence_of :url
  validates_presence_of :entry_id
  validates_uniqueness_of :entry_id
end
