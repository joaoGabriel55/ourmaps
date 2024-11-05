# frozen_string_literal: true

class CustomMapRepository < ApplicationRecord
  self.table_name = "custom_maps"

  belongs_to :owner, class_name: "UserRepository", foreign_key: :owner_id
  has_and_belongs_to_many :colaborators,
    class_name: "UserRepository",
    association_foreign_key: :colaborator_id,
    foreign_key: :custom_map_id

  def self.create!(map)
    map[:owner_id] = map[:owner][:id]
    map.delete(:owner)

    create(map)
  end

  def self.get_all!(owner_id:, paginator:)
    where(owner_id: owner_id).paginate(per_page: paginator[:per_page], page: paginator[:page])
  end

  def self.lookup!(id:)
    find(id)
  rescue ActiveRecord::RecordNotFound
    raise UseCases::CustomMaps::NotFoundError, "Custom map not found: #{id}"
  end

  def self.update!(map)
    find(map[:id]).update!(map)
  rescue ActiveRecord::RecordNotFound
    raise UseCases::CustomMaps::UpdateError, "Custom map not found: #{map[:id]}"
  end

  def self.delete!(id:)
    destroy(id)
  end
end
