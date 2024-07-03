# frozen_string_literal: true

module Adapters
  class UserRepository < ActiveRecord::Base
    self.table_name = 'users'
  end
end
