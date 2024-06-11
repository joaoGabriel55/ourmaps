# frozen_string_literal: true

require 'sinatra'
require 'sinatra/activerecord'
# require './models'

set :bind, '0.0.0.0'

get '/' do
  'Hello, world!'
end
