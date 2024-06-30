# frozen_string_literal: true

require './app/domain/user'
require './app/domain/user_repository'

module Usecases
  module Users
    class InvalidUser < StandardError; end

    class Create
      attr_accessor :user_repository, :user, :params

      def initialize(params:, user: Domain::User, repository_adapter:)
        @params = params
        @user = user
        @user_repository = Domain::UserRepository.new(repository: repository_adapter)
      end

      def call
        new_user = user.new(name: params[:name], password: params[:password])

        raise InvalidUser if new_user.valid? == false

        user_repository.create!(new_user.to_hash)
      end
    end
  end
end
