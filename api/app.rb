# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
# require './models'

set :bind, '0.0.0.0'

before do
  content_type :json
end

get '/health-check' do
  ActiveRecord::Base.connection.execute('SELECT 1')

  { database_status: 'OK' }.to_json
rescue StandardError
  { database_status: 'DOWN' }.to_json
end
