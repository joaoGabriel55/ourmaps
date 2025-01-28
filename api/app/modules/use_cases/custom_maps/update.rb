# frozen_string_literal: true

module UseCases
  module CustomMaps
    class UpdateError < StandardError; end

    class Update
      attr_accessor :custom_map_repository, :custom_map, :params

      def initialize(params:, repository_adapter:)
        @params = params
        @custom_map_repository = Domain::CustomMapRepository.new(
          repository: repository_adapter
        )
      end

      def call
        updated_map = Domain::CustomMap.new(
          id: params[:id],
          name: params[:name],
          description: params[:description],
          center: params[:center],
          content: params[:content],
          owner: params[:owner],
          collaborators: params[:collaborators],
          visibility: params[:visibility],
          created_at: params[:created_at],
          updated_at: params[:updated_at]
        )

        custom_map_repository.update!(updated_map.to_hash)
      rescue Domain::InvalidCustomMap => e
        LoggerProvider.new.error(e)
        raise UpdateError, e.message
      rescue => e
        LoggerProvider.new.error(e)
        raise UpdateError, "Error updating custom map"
      end
    end
  end
end
