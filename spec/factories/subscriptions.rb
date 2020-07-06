FactoryBot.define do
  factory :subscription do
    user { nil }
    podcast { nil }
    is_favorite { false }
    # NOTE:
    # to skip after_create
    #    https://stackoverflow.com/questions/8751175/skip-callbacks-on-factory-girl-and-rspec
  end
end
