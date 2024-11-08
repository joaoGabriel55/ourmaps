module Factories
  class CustomMapFactory
    def self.create(map)
      Domain::CustomMap.new(
        id: map.id,
        name: map.name,
        description: map.description,
        content: map.content,
        center: [ map.lat_center, map.lng_center ],
        owner: Domain::User.new(
          id: map.owner.id,
          name: map.owner.name,
          password: map.owner.password
        ),
        colaborators: map.colaborators.map do |colaborator|
          Domain::User.new(
            id: colaborator.id,
            name: colaborator.name,
            password: colaborator.password
          )
        end
      )
    end
  end
end
