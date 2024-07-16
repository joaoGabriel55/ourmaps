# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'

require 'dotenv'

Dotenv.load

require './app/adapters/controllers/users_controller'
require './app/adapters/repositories/index'

before do
  content_type :json
end

set :bind, '0.0.0.0'
set :database_file, 'config/database.yml'

def to_symbol_hash(body)
  JSON.parse(body).to_hash.transform_keys(&:to_sym)
end

get '/health-check' do
  ActiveRecord::Base.connection.execute('SELECT 1')

  { database_status: 'OK' }.to_json
rescue StandardError
  { database_status: 'DOWN' }.to_json
end

post '/api/users' do
  params = to_symbol_hash(request.body.read)

  UsersController.new(repositories:, params:).create
rescue Usecases::Users::CreateError => e
  status 422
  { error: e.message }.to_json
rescue StandardError => e
  puts e
  status 500
end
