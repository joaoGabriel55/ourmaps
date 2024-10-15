# frozen_string_literal: true

class UserRepository < ApplicationRecord
  self.table_name = "users"

  def self.get_all!(paginator:)
    paginate(per_page: paginator[:per_page], page: paginator[:page])
  end

  def self.lookup!(id:)
    find(id)
  end

  def self.delete!(id:)
    destroy(id)
  end
end
