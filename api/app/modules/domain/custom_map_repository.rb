# frozen_string_literal: true

module Domain
  class CustomMapRepository
    attr_accessor :repository

    def initialize(repository:)
      @repository = repository
    end

    def create!(map)
      created_map = repository.create!(map)

      Domain::CustomMap.new(
        id: created_map.id,
        name: created_map.name,
        description: created_map.description,
        content: created_map.content,
        owner: Domain::User.new(
          id: created_map.owner.id,
          name: created_map.owner.name,
          password: created_map.owner.password
        ),
        colaborators: created_map.colaborators.map do |colaborator|
          Domain::User.new(
            id: colaborator.id,
            name: colaborator.name,
            password: colaborator.password
          )
        end
      )
    end

    delegate :update!, to: :repository
    delegate :lookup!, to: :repository
    delegate :delete!, to: :repository

    def get_all!(owner_id:, paginator:)
      maps = repository.get_all!(owner_id:, paginator:)

      maps.map do |map|
        Domain::CustomMap.new(
          id: map.id,
          name: map.name,
          description: map.description,
          content: map.content,
          owner: Domain::User.new(
            id: map.owner.id,
            name: map.owner.name,
            password: map.owner.password
          ),
          colaborators: map.colaborators.map do |colaborator|
            Domain::User.new(
              id: map.owner.id,
              name: map.owner.name,
              password: map.owner.password
            )
          end
        )
      end
    end
  end
end
