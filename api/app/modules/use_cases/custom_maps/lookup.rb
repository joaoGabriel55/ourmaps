# frozen_string_literal: true

module UseCases
  module CustomMaps
    class LookupError < StandardError; end

    class Lookup
      attr_accessor :id, :custom_map_repository

      def initialize(id:, repository_adapter:)
        @id = id
        @custom_map_repository = Domain::CustomMapRepository.new(
          repository: repository_adapter
        )
      end

      def call
        custom_map_repository.lookup!(id:)
      rescue StandardError => e
        LoggerProvider.new.error(e)
        raise LookupError, "Error looking up custom map #{id}"
      end
    end
  end
end
