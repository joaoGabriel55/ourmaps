# frozen_string_literal: true

module UseCases
  module Users
    class NotFoundError < StandardError; end

    class LookupError < StandardError; end

    class Lookup
      attr_accessor :id, :user_repository

      def initialize(id:, repository_adapter:)
        @id = id
        @user_repository = Domain::UserRepository.new(
          repository: repository_adapter
        )
      end

      def call
        user_repository.lookup!(id:)
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
