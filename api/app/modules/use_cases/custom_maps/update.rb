# frozen_string_literal: true

module UseCases
  module CustomMaps
    class UpdateError < StandardError; end

    class Update
      attr_accessor :custom_map_repository, :custom_map, :params

      def initialize(params:, repository_adapter:, custom_map: Domain::CustomMap)
        @params = params
        @custom_map = custom_map
        @custom_map_repository = Domain::CustomMapRepository.new(
          repository: repository_adapter
        )
      end

      def call
        updated_map = custom_map.new(
          id: params[:id],
          name: params[:name],
          description: params[:description],
          content: params[:content],
          center: params[:center],
          owner: params[:owner],
          collaborators: params[:collaborators]
        )

        custom_map_repository.update!(updated_map.to_hash)
      rescue Domain::InvalidCustomMap => e
        LoggerProvider.new.error(e)
        raise UpdateError, e.message
      rescue StandardError => e
        LoggerProvider.new.error(e)
        raise UpdateError, "Error updating custom map"
      end
    end
  end
end
