FactoryBot.define do
  factory :custom_map_repository do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
    content { { 'key' => 'value' } }
    owner { FactoryBot.create(:user_repository) }
    colaborators { [ FactoryBot.create(:user_repository) ] }
  end
end
