# frozen_string_literal: true

require './app/usecases/users/create'
require './app/adapters/repositories/index'

# TODO: Fix seed!
Rails.logger.debug 'Running seeds'

create_user1 = Usecases::Users::Create.new(
  params: { name: 'John', password: '123456' },
  repository_adapter: repositories[:user_repository]
)

create_user2 = Usecases::Users::Create.new(
  params: { name: 'Jane', password: '123456' },
  repository_adapter: repositories[:user_repository]
)

create_user1.call
create_user2.call

Rails.logger.debug 'Finished seeds'
