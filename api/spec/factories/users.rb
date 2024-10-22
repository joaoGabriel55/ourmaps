FactoryBot.define do
  factory :user_repository do
    name { Faker::Name.name }
    password { Faker::Internet.password }
  end
end
