# frozen_string_literal: true

require './app/adapters/services/users_service'
require 'sinatra/base'

post '/users' do
  params = to_symbol_hash(request.body.read)

  UsersService.new(repositories:, params:).create
rescue Usecases::Users::CreateError => e
  status 422
  { error: e.message }.to_json
rescue StandardError => e
  puts e
  status 500
end
