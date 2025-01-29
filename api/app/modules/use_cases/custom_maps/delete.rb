# frozen_string_literal: true

module UseCases
  module CustomMaps
    class DeleteError < StandardError; end

    class Delete
      attr_accessor :id, :custom_map_repository

      def initialize(id:, adapter:)
        @id = id
        @custom_map_repository = Domain::CustomMapRepository.new(adapter:)
      end

      def call
        custom_map_repository.delete!(id:)
      rescue => e
        LoggerProvider.new.error(e)
        raise DeleteError, "Error deleting custom map #{id}"
      end
    end
  end
end
