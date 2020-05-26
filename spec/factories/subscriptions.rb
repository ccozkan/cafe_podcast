FactoryBot.define do
  factory :subscription do
    name { "cool podcast" }
    description { 'where i talk about cool stuff'}
    url { "https://feed.coolpodcast.test" }
    media_url { "https://coolpodcast.test/thumbnail" }
    last_publish_date { nil }
    user { nil }
    # NOTE:
    # to skip after_create
    #    https://stackoverflow.com/questions/8751175/skip-callbacks-on-factory-girl-and-rspec
  end
end
