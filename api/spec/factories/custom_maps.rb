FactoryBot.define do
  factory :custom_map do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
    lat_center { Faker::Address.latitude }
    lng_center { Faker::Address.longitude }
    content {
      {
        type: "FeatureCollection",
        features: [
          {
            type: "Feature",
            properties: {},
            geometry: {
              coordinates: [
                14.467459460702372,
                50.065357461330194
              ],
              type: "Point"
            }
          }
        ]
      }
    }
    owner { FactoryBot.create(:user) }
    collaborators { [FactoryBot.create(:user)] }
  end
end
