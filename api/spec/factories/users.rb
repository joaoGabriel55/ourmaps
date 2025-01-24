FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    created_at { DateTime.now }
    updated_at { nil }
  end
end
