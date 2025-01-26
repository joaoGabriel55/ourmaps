# frozen_string_literal: true

class CustomMap < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: :owner_id

  has_and_belongs_to_many :collaborators,
    class_name: "User",
    association_foreign_key: :collaborator_id,
    foreign_key: :custom_map_id
end
