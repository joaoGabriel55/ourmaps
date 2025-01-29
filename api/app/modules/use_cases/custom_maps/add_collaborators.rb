# frozen_string_literal: true

module UseCases
  module CustomMaps
    class AddCollaboratorsError < StandardError; end

    class NotAddYourselfError < StandardError; end

    class AddCollaborators
      attr_accessor :map, :collaborators, :owner_id, :custom_map_repository

      def initialize(map:, owner_id:, repository_adapter:, collaborators: [])
        @map = map
        @owner_id = owner_id
        @collaborators = collaborators
        @custom_map_repository = Domain::CustomMapRepository.new(
          repository: repository_adapter
        )
      end

      def call
        if collaborators.include?(owner_id)
          raise NotAddYourselfError, "You can't add yourself as a collaborator"
        end

        custom_map_repository.add_collaborators!(map_id: map.id, collaborators:)
      rescue NotAddYourselfError => e
        LoggerProvider.new.error(e)
        raise NotAddYourselfError, e.message
      rescue AddCollaboratorsError => e
        LoggerProvider.new.error(e)
        raise AddCollaboratorsError, e.message
      end
    end
  end
end
