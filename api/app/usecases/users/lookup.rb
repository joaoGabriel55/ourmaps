# frozen_string_literal: true

require './app/domain/user_repository'
require './app/shared_kernel/logger_provider'

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
        user_repository.lookup!(id:)
      rescue StandardError => e
        LoggerProvider.new.error(e)
        raise LookupError, "Error looking up user #{id}"
      end
    end
  end
end
