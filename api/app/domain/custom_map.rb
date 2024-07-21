# frozen_string_literal: true

require './app/shared_kernel/id_provider'

module Domain
  class InvalidCustomMap < StandardError; end

  class CustomMap
    attr_accessor :id, :name, :description,
      :custom_map_data, :owner, :colaborators, :created_at, :updated_at

    def initialize(
      id: nil,
      name: nil,
      description: nil,
      custom_map_data: [],
      owner: nil,
      colaborators: []
    )

      validate(name:, owner:)

      @id = id || IdProvider.next_id
      @name = name
      @description = description
      @custom_map_data = custom_map_data
      @owner = owner
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
        owner: owner.to_hash,
        colaborators: colaborators&.map(&:to_hash),
        created_at:,
        updated_at:
      }
    end

    private

    def validate(name:, owner:)
      if name.nil?
        raise InvalidCustomMap, 'Name is required'
      elsif owner.nil?
        raise InvalidCustomMap, 'Owner is required'
      end
    end
  end
end
