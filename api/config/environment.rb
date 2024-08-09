# frozen_string_literal: true

# specifies which environment to run
ENV['RACK_ENV'] ||= 'development'

# Require Gems before running code
require 'bundler/setup'
Bundler.require(:default, ENV.fetch('RACK_ENV', nil))
# ^^ This will get the gems from the default group,
# and the group specified in ENV['RACK_ENV']
