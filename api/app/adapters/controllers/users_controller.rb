# frozen_string_literal: true

require './app/usecases/users/create'

class UsersController

  def initialize(repositories:)
    @repositories = repositories
  end

  attr_reader :repositories

  def create(params)
    create_user = Usecases::Users::Create.new(
      params:,
      repository_adapter: repositories[:user_repository],
    )

    { result: create_user.call }.to_json
  end
end
