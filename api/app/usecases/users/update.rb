# frozen_string_literal: true

require './app/domain/user'
require './app/domain/user_repository'
require './app/shared_kernel/logger_provider'

module Usecases
  module Users
    class UpdateError < StandardError; end

    class Update
      attr_accessor :user_repository, :user, :params

      def initialize(params:, repository_adapter:, user: Domain::User)
        @params = params
        @user = user
        @user_repository = Domain::UserRepository.new(
          repository: repository_adapter
        )
      end

      def call
        updated_user = user.new(
          id: params[:id],
          name: params[:name],
          password: params[:password]
        )

        user_repository.update!(updated_user.to_hash)
      rescue Domain::InvalidUser => e
        LoggerProvider.new.error(e)
        raise UpdateError, e.message
      rescue StandardError => e
        LoggerProvider.new.error(e)
        raise UpdateError, 'Error updating user'
      end
    end
  end
end
