# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
require 'dotenv'

Dotenv.load

require './app/adapters/controllers/users_controller'
require './app/adapters/repositories/user_repository'

before do
  content_type :json
end

repositories = {
  user_repository: UserRepository.new,
}

class App < Sinatra::Base
  # development settings
  configure :development do
    register Sinatra::Reloader
  end

  set :database_file, 'config/database.yml'
  set :bind, '0.0.0.0'

  get '/health-check' do
    ActiveRecord::Base.connection.execute('SELECT 1')

    { database_status: 'OK' }.to_json
  rescue StandardError
    { database_status: 'DOWN' }.to_json
  end

  post '/api/users' do
    UsersController.new(repositories:).create(params)
  rescue Usecases::Users::CreateError
    status 422
  rescue StandardError => e
    puts e
    status 500
  end
end
