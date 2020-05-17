class Content < ApplicationRecord
  belongs_to :subscription, dependent: :destroy
  belongs_to :user, dependent: :destroy

  validates :url, presence: true
  validates :entry_id, uniqueness: { scope: :user,
                                     message: "user has already this content"}
end
