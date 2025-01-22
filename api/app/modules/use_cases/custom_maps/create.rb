# frozen_string_literal: true

module UseCases
  module CustomMaps
    class CreateError < StandardError; end

    class Create
      attr_accessor :params, :custom_map_repository

      def initialize(params:, repository_adapter:)
        @params = params
        @custom_map_repository = Domain::CustomMapRepository.new(
          repository: repository_adapter
        )
      end

      def call
        new_map = Domain::CustomMap.new(
          id: IdProvider.new.next_id,
          name: params[:name],
          description: params[:description],
          center: params[:center],
          content: params[:content],
          owner: params[:owner],
          collaborators: params[:collaborators],
          visibility: params[:visibility]
        )

        custom_map_repository.create!(new_map.to_hash)
      rescue Domain::InvalidCustomMap => e
        LoggerProvider.new.error(e)
        raise CreateError, e.message
      rescue StandardError => e
        LoggerProvider.new.error(e)
        raise CreateError, "Error creating custom map"
      end
    end
  end
end
