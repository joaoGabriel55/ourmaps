# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
# require './models'

# set :database, {
#   adapter: 'postgresql',
#   database: 'ourmaps_development',
#   host: 'db',
#   username: 'postgres',
#   password: 'password'
# }

set :bind, '0.0.0.0'

get '/' do
  'Hello, world!'
end
