# frozen_string_literal: true

require_relative '../../usecases/users/create'
require_relative '../../usecases/users/get_all'
require_relative '../../usecases/users/lookup'
require_relative '../../usecases/users/update'
require_relative '../../usecases/users/delete'
require_relative '../../shared_kernel/id_provider'

class UsersService
  def initialize(repository:)
    @repository_adapter = repository
  end

  attr_reader :repository_adapter

  def create(params:)
    params[:id] = IdProvider.new.next_id

    Usecases::Users::Create.new(params:, repository_adapter:).call
  end

  def update(user:, params:)
    user = user.merge(params)

    Usecases::Users::Update.new(params: user, repository_adapter:).call
  end

  def get_all
    Usecases::Users::GetAll.new(repository_adapter:).call
  end

  def find_by_id(id)
    Usecases::Users::Lookup.new(id:, repository_adapter:).call
  end

  def delete(id)
    Usecases::Users::Delete.new(id:, repository_adapter:).call
  end
end
