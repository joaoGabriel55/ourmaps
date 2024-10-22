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
        user = user_repository.lookup!(id:)

        Domain::User.new(
          id: user.id,
          name: user.name,
          password: user.password,
          created_at: user.created_at,
          updated_at: user.updated_at
        )
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
