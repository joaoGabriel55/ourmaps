# frozen_string_literal: true

require_relative '../../usecases/users/create'
require_relative '../../shared_kernel/id_provider'

class UsersService
  def initialize(repositories:, params:)
    params[:id] = IdProvider.new.next_id

    @create_user = Usecases::Users::Create.new(
      params:,
      repository_adapter: repositories[:user_repository]
    )
  end

  attr_reader :create_user

  def create
    { data: create_user.call }.to_json
  end
end
