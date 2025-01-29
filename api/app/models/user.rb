# frozen_string_literal: true

class User < ApplicationRecord
  include PgSearch::Model

  require "securerandom"

  has_secure_password

  has_and_belongs_to_many :custom_maps, dependent: :destroy

  pg_search_scope :query_search,
    against: [:name, :email],
    using: {
      tsearch: {prefix: true}
    }
end
