# frozen_string_literal: true

module Domain
  class InvalidGeometry < StandardError; end

  class Geometry
    attr_accessor :type, :coordinates, :geometries

    def initialize(type: nil, coordinates: nil, geometries: nil)
      validate(type:, coordinates:, geometries:)

      @type = type
      @coordinates = coordinates
      @geometries = geometries
    end

    def to_hash
      if type == 'GeometryCollection'
        {
          type: 'Feature',
          geometry: { type:, geometries: }
        }
      else
        {
          type: 'Feature',
          geometry: { type:, coordinates: }
        }
      end
    end

    private

    def validate(type:, coordinates:, geometries:)
      valid_types = %w[
        Point
        LineString
        Polygon
        MultiPoint
        MultiLineString
        MultiPolygon
        GeometryCollection
      ].freeze

      if type.nil?
        raise InvalidGeometry, 'Type is required'
      elsif valid_types.exclude?(type)
        raise InvalidGeometry, 'Type is invalid'
      elsif type != 'GeometryCollection' && coordinates.nil?
        raise InvalidGeometry, 'Coordinates is required'
      elsif type == 'GeometryCollection' && geometries.nil?
        raise InvalidGeometry, 'Geometries is required'
      end
    end
  end
end
