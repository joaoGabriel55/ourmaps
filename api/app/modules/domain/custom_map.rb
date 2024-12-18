# frozen_string_literal: true

module Domain
  class InvalidCustomMap < StandardError; end

  class CustomMap
    attr_accessor :id,
      :name,
      :description,
      :center,
      :content,
      :owner,
      :collaborators,
      :created_at,
      :updated_at

    def initialize(
      id: nil,
      name: nil,
      description: nil,
      center: nil,
      content: nil,
      owner: nil,
      collaborators: [],
      created_at: nil,
      updated_at: nil
    )

      validate(id:, name:, owner:, center:)

      @id = id
      @name = name
      @description = description
      @center = center
      @content = content ? Domain::Geometry.new(geometry: JSON.parse(content.to_json)) : nil
      @owner = owner
      @collaborators = collaborators || []
      @created_at = created_at || DateTime.now
      @updated_at = updated_at || nil
    end

    def to_hash
      {
        id:,
        name:,
        description:,
        center:,
        content: content ? content.to_hash : nil,
        owner: owner.to_hash,
        collaborators: collaborators&.map(&:to_hash),
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
