# frozen_string_literal: true

module UseCases
  module Users
    class DeleteError < StandardError; end

    class Delete
      attr_accessor :id, :user_repository

      def initialize(id:, adapter:)
        @id = id
        @user_repository = Domain::UserRepository.new(adapter:)
      end

      def call
        user_repository.delete!(id:)
      rescue => e
        LoggerProvider.new.error(e)
        raise DeleteError, "Error deleting user #{id}"
      end
    end
  end
end
