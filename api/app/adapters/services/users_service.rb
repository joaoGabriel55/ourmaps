# frozen_string_literal: true

require_relative '../../usecases/users/create'
require_relative '../../usecases/users/get_all'
require_relative '../../shared_kernel/id_provider'

class UsersService
  def initialize(repositories:)
    @repository_adapter = repositories[:user_repository]
  end

  attr_reader :repository_adapter

  def create(params:)
    params[:id] = IdProvider.new.next_id

    create_user = Usecases::Users::Create.new(params:, repository_adapter:)

    { data: create_user.call }.to_json
  end

  def get_all
    get_all_users = Usecases::Users::GetAll.new(repository_adapter:)
    { data: get_all_users.call }.to_json
  end
end
