# frozen_string_literal: true

require './app/adapters/services/users_service'
require 'sinatra/base'

post '/users' do
  repository = repositories[:user_repository]

  request.body.rewind
  params = to_symbol_hash(request.body.read)

  status 201

  created_user = UsersService.new(repository:).create(params:)

  { data: created_user }.to_json
rescue Usecases::Users::CreateError => e
  LoggerProvider.new.error(e)
  status 422
  { error: e.message }.to_json
rescue StandardError => e
  LoggerProvider.new.error(e)
  status 500
end

patch '/users/:id' do
  repository = repositories[:user_repository]

  request.body.rewind
  params = to_symbol_hash(request.body.read)

  user = UsersService.new(repository:).find_by_id(params[:id])

  updated_user = UsersService.new(repository:).update(user:, params:)

  { data: updated_user }.to_json
rescue Usecases::Users::LookupError => e
  LoggerProvider.new.error(e)
  status 404
  { error: e.message }.to_json
rescue Usecases::Users::UpdateError => e
  LoggerProvider.new.error(e)
  status 422
  { error: e.message }.to_json
rescue StandardError => e
  LoggerProvider.new.error(e)
  status 500
end

get '/users' do
  repository = repositories[:user_repository]

  users = UsersService.new(repository:).get_all

  { data: users }.to_json
rescue Usecases::Users::CreateError => e
  LoggerProvider.new.error(e)
  status 422
  { error: e.message }.to_json
rescue StandardError => e
  LoggerProvider.new.error(e)
  status 500
end

get '/users/:id' do
  repository = repositories[:user_repository]

  user = UsersService.new(repository:).find_by_id(params[:id])

  { data: user }.to_json
rescue Usecases::Users::LookupError => e
  LoggerProvider.new.error(e)
  status 404
  { error: "User not found: #{params[:id]}" }.to_json
rescue StandardError => e
  LoggerProvider.new.error(e)
  status 500
end

delete '/users/:id' do
  repository = repositories[:user_repository]

  user = UsersService.new(repository:).find_by_id(params[:id])

  UsersService.new(repository:).delete(user['id'])

  status 204
rescue Usecases::Users::LookupError => e
  LoggerProvider.new.error(e)
  status 404
  { error: "User not found: #{params[:id]}" }.to_json
rescue StandardError => e
  LoggerProvider.new.error(e)
  status 500
end
