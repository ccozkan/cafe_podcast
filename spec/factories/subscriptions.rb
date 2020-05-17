FactoryBot.define do
  factory :subscription do
    name { "cool podcast" }
    url { "https://feed.coolpodcast.test" }
    media_url { "https://coolpodcast.test/thumbnail" }
    last_publish { Date.today - 1.day }
    user { nil }
  end
end
