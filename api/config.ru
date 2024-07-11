require 'sinatra/activerecord/rake'
require 'rack/unreloader'

Unreloader = Rack::Unreloader.new { App }
Unreloader.require './app.rb'

run Unreloader
