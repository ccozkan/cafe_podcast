FactoryBot.define do
  factory :subscription do
    name { "cool podcast" }
    description { 'where i talk about cool stuff'}
    url { "https://feed.coolpodcast.test" }
    media_url { "https://coolpodcast.test/thumbnail" }
    last_publish_date { nil }
    user { nil }
  end
end
