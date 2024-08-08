# frozen_string_literal: true

require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'rack/unreloader'
require 'dotenv'

Dotenv.load

require './app/adapters/routes/users_routes'
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
