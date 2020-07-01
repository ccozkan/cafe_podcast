class Podcast < ApplicationRecord
  has_many :episodes, dependent: :destroy
  has_many :subscriptions
  has_many :users, through: :subscriptions
  has_one :original_adder

  validates :url, presence: true
  validates :url, uniqueness: true

  after_commit :first_time_catch_up, on: :create
  after_commit :subscribe_user, on: :create

  extend FriendlyId
  friendly_id :slug_candidate, use: :slugged

  def slug_candidate
    self.name.gsub(/\P{ASCII}/, '').downcase
  end

  def should_generate_new_friendly_id?
    name_changed?
  end

  def cool_abbreviation
    if self.name.nil?
      SecureRandom.hex(5)
    else
      abr = self.name.gsub(/\P{ASCII}/, '').split.map(&:first).join
      abr[0..4] if abr.length > 5
    end
  end

  def subscribe_user
    if self.original_adder_id
      sub = Subscription.new(user_id: self.original_adder_id, podcast_id: self.id)
      sub.save!
    end
  end

  def first_time_catch_up
    if Podcast.find_by(url: self.url).nil?
      feed = FeedReceiver.call(self.url)

      feed.entries.each do |f|
        contents = EntryParser.call(f)
        new_episode = Episode.new(contents)
        new_episode.podcast_id = id
        new_episode.save!
      end
    end
  end
end
