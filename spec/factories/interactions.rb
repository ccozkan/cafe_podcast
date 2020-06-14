FactoryBot.define do
  factory :interaction do
    episode { nil }
    user { nil }
    listened { false }
    starred { false }
  end
end
