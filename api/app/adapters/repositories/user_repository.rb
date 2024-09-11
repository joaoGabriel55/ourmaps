# frozen_string_literal: true

class UserRepository < ActiveRecord::Base
  self.table_name = 'users'

  def self.get_all!(paginator:)
    all
  end

  def self.lookup!(id:)
    find(id)
  end

  def self.delete!(id:)
    destroy(id)
  end
end
