# frozen_string_literal: true

module Domain
  class InvalidMapContent < StandardError; end

  class MapContent
    attr_accessor :id, :image, :geometry

    def initialize(id: nil, image: nil, geometry: nil)
      validate(id:, image:, geometry:)

      @id = id
      @image = image
      @geometry = geometry
    end

    def to_hash
      {
        id:,
        image: image&.to_hash,
        geometry: geometry.to_hash
      }.compact
    end

    private

    def validate(id:, image:, geometry:)
      if id.nil?
        raise InvalidMapContent, 'Id is required'
      elsif geometry.nil?
        raise InvalidMapContent, 'Geometry is required'
      end
    end
  end
end
