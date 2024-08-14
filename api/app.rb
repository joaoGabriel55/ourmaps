# frozen_string_literal: true

require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'rack/unreloader'
require 'dotenv'
require_relative 'app/shared_kernel/camelize'
require_relative 'app/shared_kernel/logger_provider'
require_relative 'config/environment'

Dotenv.load

def to_symbol_hash(body)
  JSON.parse(body).transform_keys(&:to_sym)
end

set :bind, '0.0.0.0'
set :default_content_type, :json
set :database_file, 'config/database.yml'

require './app/adapters/routes/users_routes'
require './app/adapters/repositories/index'

get '/health-check' do
  ActiveRecord::Base.connection.execute('SELECT 1')

  { database_status: 'OK' }.to_json
rescue StandardError
  { database_status: 'DOWN' }.to_json
end
