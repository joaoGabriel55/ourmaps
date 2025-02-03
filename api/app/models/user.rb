# frozen_string_literal: true

class User < ApplicationRecord
  include PgSearch::Model

  require "securerandom"

  has_secure_password

  has_many :custom_map_collaborators
  has_many :custom_maps, through: :custom_map_collaborators, dependent: :destroy

  pg_search_scope :query_search,
    against: [:name, :email],
    using: {
      tsearch: {prefix: true}
    }
end
