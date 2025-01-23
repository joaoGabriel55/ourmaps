# frozen_string_literal: true

class CustomMapRepository < ApplicationRecord
  self.table_name = "custom_maps"

  belongs_to :owner, class_name: "UserRepository", foreign_key: :owner_id
  has_and_belongs_to_many :collaborators,
    class_name: "UserRepository",
    association_foreign_key: :collaborator_id,
    foreign_key: :custom_map_id

  def self.create!(map)
    map[:owner_id] = map[:owner][:id]
    map[:lat_center] = map[:center][0]
    map[:lng_center] = map[:center][1]

    map.delete(:center)
    map.delete(:owner)

    created_map = create(map)

    Factories::CustomMapFactory.create(created_map)
  end

  def self.get_all!(owner_id:, paginator:)
    maps = where(owner_id: owner_id).paginate(per_page: paginator[:per_page], page: paginator[:page])

    maps.map do |map|
      Factories::CustomMapFactory.create(map)
    end
  end

  def self.lookup!(id:)
    map = find(id)

    Factories::CustomMapFactory.create(map)
  rescue ActiveRecord::RecordNotFound
    raise UseCases::CustomMaps::NotFoundError, "Custom map not found: #{id}"
  end

  def self.update!(map)
    map[:owner_id] = map[:owner][:id]
    map[:lat_center] = map[:center][0]
    map[:lng_center] = map[:center][1]

    map.delete(:center)
    map.delete(:owner)

    db_map = find(map[:id])

    db_map.update(map)

    db_map.reload

    Factories::CustomMapFactory.create(db_map)
  rescue ActiveRecord::RecordNotFound
    raise UseCases::CustomMaps::UpdateError, "Custom map not found: #{map[:id]}"
  end

  def self.delete!(id:)
    destroy(id)
  end
end
