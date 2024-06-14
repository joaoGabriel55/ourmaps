# frozen_string_literal: true

class CustomMap
  attr_accessor :name, :description, :custom_map_data, :colaborators, :created_at,
    :updated_at

  def initialize(name:, description:, custom_map_data:, colaborators: [])
    @name = name
    @description = description
    @custom_map_data = custom_map_data
    @colaborators = colaborators
    @created_at = DateTime.now
    @updated_at = nil
  end

  def to_hash
    {
      name:,
      description:,
      custom_map_data:,
      colaborators:,
      created_at:,
      updated_at:
    }
  end
end
