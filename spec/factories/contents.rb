FactoryBot.define do
  factory :content do
    url { "MyString" }
    title { "MyString" }
    summary { "MyText" }
    publish_date { "2020-05-17" }
    duration { 1 }
    listened { false }
    starred { false }
    entry_id { "MyString" }
    subscription { nil }
    user { nil }
  end
end
