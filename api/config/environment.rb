# frozen_string_literal: true

require 'rubygems'
require 'bundler'

Bundler.require(:default)                   # load all the default gems
Bundler.require(Sinatra::Base.environment)  # load all the environment specific gems

require 'active_support/deprecation'
require 'active_support/all'

Dotenv.load

set :database, { adapter: 'postgresql', database: ENV.fetch('DATABASE_PATH', nil) }
set :bind, '0.0.0.0'
