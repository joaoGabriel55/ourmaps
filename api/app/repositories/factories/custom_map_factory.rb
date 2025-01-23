module Factories
  class CustomMapFactory
    def self.create(map)
      Domain::CustomMap.new(
        id: map.id,
        name: map.name,
        description: map.description,
        visibility: map.visibility,
        content: map.content ? Domain::Geometry.new(geometry: map.content) : nil,
        center: [ map.lat_center, map.lng_center ],
        owner: Domain::User.new(
          id: map.owner.id,
          name: map.owner.name,
          password: map.owner.password
        ),
        collaborators: map.collaborators.map do |collaborator|
          Domain::User.new(
            id: collaborator.id,
            name: collaborator.name,
            password: collaborator.password
          )
        end,
        created_at: map.created_at,
        updated_at: map.updated_at
      )
    end
  end
end
