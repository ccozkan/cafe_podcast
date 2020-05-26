class Content < ApplicationRecord
  belongs_to :subscription
  belongs_to :user

  validates :url, presence: true
  validates :entry_id, uniqueness: { scope: :user,
                                     message: "user has already this content"}
end
