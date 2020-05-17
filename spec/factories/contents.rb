FactoryBot.define do
  factory :content do
    url { "https://coolpodcast.test/episode_1.mp3" }
    title { "Cool Episode" }
    summary { "Discussion about bla bla bla" }
    publish_date { "Date.today - 1.day" }
    duration { 20 }
    listened { false }
    starred { false }
    entry_id { "ABCXYZ" }
    subscription { nil }
    user { nil }
  end
end
