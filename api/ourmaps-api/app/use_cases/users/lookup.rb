# frozen_string_literal: true
module Usecases
  module Users
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

        raise LookupError, "User not found: #{id}" if user.nil?

        Domain::User.new(
          id: user.id,
          name: user.name,
          password: user.password,
          created_at: user.created_at,
          updated_at: user.updated_at
        ).response
      rescue StandardError => e
        LoggerProvider.new.error(e)
        raise LookupError, e.message
      end
    end
  end
end
