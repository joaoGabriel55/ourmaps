# frozen_string_literal: true

module UseCases
  module CustomMaps
    class RemoveCollaboratorsError < StandardError; end

    class RemoveCollaborators
      attr_accessor :map, :removed_collaborators, :owner_id, :custom_map_repository

      def initialize(map:, owner_id:, adapter:, removed_collaborators: [])
        @map = map
        @owner_id = owner_id
        @removed_collaborators = removed_collaborators
        @custom_map_repository = Domain::CustomMapRepository.new(adapter:)
      end

      def call
        custom_map_repository.remove_collaborators!(map_id: map.id, removed_collaborators:)
      rescue => e
        LoggerProvider.new.error(e)
        raise RemoveCollaboratorsError, e.message
      end
    end
  end
end
