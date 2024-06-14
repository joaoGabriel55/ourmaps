# frozen_string_literal: true

require './app/shared_kernel/id_provider'

class CustomMap
  attr_accessor :id, :name, :description, :custom_map_data, :colaborators, :created_at,
    :updated_at

  def initialize(name:, description:, custom_map_data: [], colaborators: [])
    @id = IdProvider.next_id
    @name = name
    @description = description
    @custom_map_data = custom_map_data
    @colaborators = colaborators
    @created_at = DateTime.now
    @updated_at = nil
  end

  def to_hash
    {
      id:,
      name:,
      description:,
      custom_map_data:,
      colaborators:,
      created_at:,
      updated_at:
    }
  end
end
