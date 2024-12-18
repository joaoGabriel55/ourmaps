# frozen_string_literal: true

module Domain
  class InvalidGeometry < StandardError; end

  class Geometry
    attr_accessor :geometry

    def initialize(geometry: nil)
      validate(geometry:)

      @geometry = geometry
    end

    def to_hash
      geometry.deep_symbolize_keys
    end

    private

    def validate(geometry:)
      lint_validate = Geojsonlint.validate(geometry)

      raise InvalidGeometry, "Invalid geometry" unless lint_validate.valid?
    end
  end
end
