# frozen_string_literal: true

class UserRepository < ActiveRecord::Base
  self.table_name = 'users'

  def self.get_all!(paginator:)
    self.all
  end
end
