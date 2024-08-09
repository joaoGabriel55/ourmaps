# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require 'rubygems'
require 'bundler'
require 'active_support/deprecation'
require 'active_support/all'
require 'database_cleaner'

require_relative '../app'

Bundler.require(:default)                   # load all the default gems
Bundler.require(Sinatra::Base.environment)  # load all the environment specific gems

DatabaseCleaner.strategy = :truncation

Dotenv.load

def app
  Sinatra::Application
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.disable_monkey_patching!
  config.warnings = true
  config.default_formatter = 'doc' if config.files_to_run.one?
  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed

  DatabaseCleaner.allow_remote_database_url = true

  config.before(:all) do
    DatabaseCleaner.clean
  end

  config.after do
    DatabaseCleaner.clean
  end
end
