# frozen_string_literal: true

require './app/domain/user'
require './app/adapters/user_repository'

module Users
  class InvalidUser < StandardError; end

  class Create
    attr_accessor :user_repository, :user, :params

    def initialize(params:, user: User, user_repository: UserRepository)
      @params = params
      @user = user
      @user_repository = user_repository
    end

    def call
      new_user = user.new(name: params[:name], password: params[:password])

      raise InvalidUser if new_user.valid? == false

      user_repository.create!(new_user.to_hash)
    end
  end
end
