# frozen_string_literal: true

module UseCases
  module CustomMaps
    class NotFoundError < StandardError; end

    class LookupError < StandardError; end

    class NotMapOwnerError < StandardError; end

    class Lookup
      attr_accessor :id, :current_user_id, :custom_map_repository

      def initialize(id:, current_user_id:, repository_adapter:)
        @id = id
        @current_user_id = current_user_id
        @custom_map_repository = Domain::CustomMapRepository.new(
          repository: repository_adapter
        )
      end

      def call
        map = custom_map_repository.lookup!(id:)

        unless authorized_to_access?(map)
          raise NotMapOwnerError, "You don't have permission to access this map"
        end

        map
      rescue NotFoundError => e
        LoggerProvider.new.error(e)
        raise NotFoundError, e.message
      rescue NotMapOwnerError => e
        LoggerProvider.new.error(e)
        raise NotMapOwnerError, e.message
      rescue => e
        LoggerProvider.new.error(e)
        raise LookupError, e.message
      end

      private

      def authorized_to_access?(map)
        map.owner.id == current_user_id || map.visibility != "private"
      end
    end
  end
end
