# frozen_string_literal: true

require './app/usecases/users/create'
require './app/adapters/repositories/index'
require './app/shared_kernel/logger_provider'

# TODO: Fix seed!
LoggerProvider.new.info('Running seeds')

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

LoggerProvider.new.info('Finished seeds')
