# frozen_string_literal: true

class CustomMap < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: :owner_id

  has_many :custom_map_collaborators, dependent: :destroy
  has_many :collaborators, through: :custom_map_collaborators, source: :user
end
