# frozen_string_literal: true

class User < ApplicationRecord
  require "securerandom"

  has_secure_password

  has_and_belongs_to_many :custom_maps, dependent: :destroy
end
