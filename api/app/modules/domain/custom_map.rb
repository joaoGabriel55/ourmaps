# frozen_string_literal: true

module Domain
  class InvalidCustomMap < StandardError; end

  class CustomMap
    attr_accessor :id,
      :name,
      :description,
      :center,
      :content, :owner, :colaborators, :created_at, :updated_at

    def initialize(
      id: nil,
      name: nil,
      description: nil,
      center: nil,
      content: [],
      owner: nil,
      colaborators: [],
      created_at: nil,
      updated_at: nil
    )

      validate(id:, name:, owner:, center:)

      @id = id
      @name = name
      @description = description
      @center = center
      @content = content
      @owner = owner
      @colaborators = colaborators || []
      @created_at = created_at || DateTime.now
      @updated_at = updated_at || nil
    end

    def to_hash
      {
        id:,
        name:,
        description:,
        center:,
        content:,
        owner: owner.to_hash,
        colaborators: colaborators&.map(&:to_hash),
        created_at:,
        updated_at:
      }
    end

    private

    def validate(id:, name:, owner:, center:)
      raise InvalidCustomMap, "Id is required" if id.nil?
      raise InvalidCustomMap, "Name is required" if name.nil?
      raise InvalidCustomMap, "Owner is required" if owner.nil?
      raise InvalidCustomMap, "Center is required" unless valid_center?(center)
    end

    def valid_center?(center)
      center&.length == 2 && center[0].is_a?(Float) && center[1].is_a?(Float)
    end
  end
end
