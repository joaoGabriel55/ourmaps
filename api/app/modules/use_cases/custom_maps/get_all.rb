# frozen_string_literal: true

module UseCases
  module CustomMaps
    class GetAllError < StandardError; end

    class GetAll
      attr_accessor :owner_id, :paginator, :custom_map_repository

      def initialize(owner_id:, repository_adapter:,
                     paginator: { per_page: 10, page: 1 })
        @owner_id = owner_id
        @paginator = paginator
        @custom_map_repository = Domain::CustomMapRepository.new(
          repository: repository_adapter
        )
      end

      def call
        custom_map_repository.get_all!(owner_id:, paginator:)
      rescue StandardError => e
        LoggerProvider.new.error(e)
        raise GetAllError, "Error fetching custom maps for owner #{owner_id}"
      end
    end
  end
end
