# frozen_string_literal: true

module Domain
  class CustomMapRepository
    attr_accessor :repository

    def initialize(repository:)
      @repository = repository
    end

    def create!(map)
      repository.create!(map)
    end

    def get_all!(owner_id:, filters:, paginator:)
      repository.get_all!(owner_id:, filters:, paginator:)
    end

    def lookup!(id:)
      repository.lookup!(id:)
    end

    def add_collaborators!(map_id:, collaborators:)
      repository.add_collaborators!(map_id:, collaborators:)
    end

    delegate :update!, to: :repository
    delegate :delete!, to: :repository
  end
end
