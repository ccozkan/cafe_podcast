FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.test"}
    sequence(:username) { |n| "person#{n}" }
    password {'testpassword'}
  end
end
