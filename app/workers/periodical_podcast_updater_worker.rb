class PeriodicalPodcastUpdaterWorker
  include Sidekiq::Worker
  #  sidekiq_options retry: false

  def perform
    users = User.all
    users.each do |user|
      User.update_subscribed_podcasts(user)
    end
  end
end
# Sidekiq::Cron::Job.create(name: 'Subscription Update - every hour', cron: '1 * * * *', class: 'PeriodicalPodcastUpdaterWorker')
