# frozen_string_literal: true

require './app/domain/custom_map'
require './app/domain/custom_map_repository'
require './app/shared_kernel/logger_provider'

module Usecases
  module CustomMaps
    class CreateError < StandardError; end

    class Create
      attr_accessor :custom_map_repository, :custom_map, :params

      def initialize(params:, repository_adapter:, custom_map: Domain::CustomMap)
        @params = params
        @custom_map = custom_map
        @custom_map_repository = Domain::CustomMapRepository.new(
          repository: repository_adapter
        )
      end

      def call
        new_map = custom_map.new(
          name: params[:name],
          description: params[:description],
          custom_map_data: params[:custom_map_data],
          owner: params[:owner],
          colaborators: params[:colaborators]
        )

        custom_map_repository.create!(new_map.to_hash)

        new_map.to_hash
      rescue Domain::InvalidCustomMap => e
        LoggerProvider.new.error(e)
        raise CreateError, e.message
      rescue StandardError => e
        LoggerProvider.new.error(e)
        raise CreateError, 'Error creating custom map'
      end
    end
  end
end
