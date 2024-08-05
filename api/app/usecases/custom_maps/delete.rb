# frozen_string_literal: true

require './app/domain/custom_map_repository'
require './app/shared_kernel/logger_provider'

module Usecases
  module CustomMaps
    class DeleteError < StandardError; end

    class Delete
      attr_accessor :id, :custom_map_repository

      def initialize(id:, repository_adapter:)
        @id = id
        @custom_map_repository = Domain::CustomMapRepository.new(
          repository: repository_adapter
        )
      end

      def call
        custom_map_repository.delete!(id:)
      rescue StandardError => e
        LoggerProvider.new.error(e)
        raise DeleteError, 'Error deleting custom map'
      end
    end
  end
end
