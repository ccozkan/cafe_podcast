FactoryBot.define do
  factory :episode do
    url { "https://coolpodcast.test/episode_1.mp3" }
    title { "Cool Episode" }
    summary { "Discussion about bla bla bla" }
    publish_date { "Date.today - 1.day" }
    duration { 20 }
    podcast { nil }
  end
end
