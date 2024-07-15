# frozen_string_literal: true

require './app/usecases/users/create'

class UsersController
  def initialize(repositories:, params:)
    @create_user = Usecases::Users::Create.new(
      params:,
      repository_adapter: repositories[:user_repository]
    )
  end

  attr_reader :create_user

  def create
    { result: create_user.call }.to_json
  end
end
