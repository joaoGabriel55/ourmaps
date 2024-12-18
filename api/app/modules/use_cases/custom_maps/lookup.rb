# frozen_string_literal: true

module UseCases
  module CustomMaps
    class NotFoundError < StandardError; end

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
      rescue NotFoundError => e
        LoggerProvider.new.error(e)
        raise NotFoundError, e.message
      rescue StandardError => e
        LoggerProvider.new.error(e)
        raise LookupError, e.message
      end
    end
  end
end
