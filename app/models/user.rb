class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :subscriptions
  has_many :contents, through: :subscriptions

  def self.update_contents(user)
    subscriptions = Subscription.where(user_id: user.id)
    subscriptions.each do |s|
      feed_url = s.url
      xml = HTTParty.get(feed_url).body
      feed = Feedjira.parse(xml)

      contents = feed.entries
      contents.each do |c|
        title = c.title
        summary = c.summary
        entry_id = c.entry_id
        url = c.enclosure_url
        publish_date = c.published.to_date
        # TODO: convert publish_date in database to simply date
        # - in subscripton model
        # - in content model

        time = (c.enclosure_length.to_i / 1024.0) / 16.0
        duration = (time / 60).ceil
        # TODO: Better alternative to duration calculation
        # enclosure_length to minutes
        # might not be most accurate
        # might not be the best choice
        # itunes provides itunes_duration
        # but how about other providers?
        # duration is an integer in db

        if Content.where(entry_id: c.entry_id, user_id: s.user_id).empty?
          new_content = Content.new(subscription_id: s.id,
                                    user_id: user.id,
                                    title: title,
                                    url: url,
                                    summary: summary,
                                    entry_id: entry_id,
                                    publish_date: publish_date
                     )
          new_content.save!
        end
      end

      s.last_publish = s.contents.map(&:publish_date).max
      s.name = feed.title
      # TODO: description is needed? or provided?

      s.save!
    end
  end
end
