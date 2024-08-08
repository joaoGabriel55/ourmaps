# frozen_string_literal: true

require './app/domain/user'
require './app/domain/user_repository'
require './app/shared_kernel/logger_provider'

module Usecases
  module Users
    class CreateError < StandardError; end

    class Create
      attr_accessor :user_repository, :user, :params

      def initialize(params:, repository_adapter:, user: Domain::User)
        @params = params
        @user = user
        @user_repository = Domain::UserRepository.new(repository: repository_adapter)
      end

      def call
        new_user = user.new(id: params[:id], name: params[:name], password: params[:password])

        user_repository.create!(new_user.to_hash)

        new_user.to_hash
      rescue Domain::InvalidUser => e
        LoggerProvider.new.error(e)
        raise CreateError, e.message
      rescue StandardError => e
        LoggerProvider.new.error(e)
        raise CreateError, 'Error creating user'
      end
    end
  end
end
