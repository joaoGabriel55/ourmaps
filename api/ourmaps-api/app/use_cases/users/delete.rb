# frozen_string_literal: true

module Usecases
  module Users
    class DeleteError < StandardError; end

    class Delete
      attr_accessor :id, :user_repository

      def initialize(id:, repository_adapter:)
        @id = id
        @user_repository = Domain::UserRepository.new(
          repository: repository_adapter
        )
      end

      def call
        user_repository.delete!(id:)
      rescue StandardError => e
        LoggerProvider.new.error(e)
        raise DeleteError, "Error deleting user #{id}"
      end
    end
  end
end
