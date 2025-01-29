# frozen_string_literal: true

module Domain
  class CustomMapRepository
    attr_accessor :adapter

    def initialize(adapter:)
      @adapter = adapter
    end

    def create!(map)
      adapter.create!(map)
    end

    def get_all!(owner_id:, filters:, paginator:)
      adapter.get_all!(owner_id:, filters:, paginator:)
    end

    def lookup!(id:)
      adapter.lookup!(id:)
    end

    def add_collaborators!(map_id:, collaborators:)
      adapter.add_collaborators!(map_id:, collaborators:)
    end

    def remove_collaborators!(map_id:, removed_collaborators:)
      adapter.remove_collaborators!(map_id:, removed_collaborators:)
    end

    delegate :update!, to: :adapter
    delegate :delete!, to: :adapter
  end
end
