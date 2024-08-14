# frozen_string_literal: true

require './app/adapters/services/users_service'
require 'sinatra/base'


post '/users' do
  request.body.rewind
  params = to_symbol_hash(request.body.read)

  status 201

  UsersService.new(repositories:, params:).create
rescue Usecases::Users::CreateError => e
  LoggerProvider.new.error(e)
  status 422
  { error: e.message }.to_json
rescue StandardError => e
  LoggerProvider.new.error(e)
  status 500
end
