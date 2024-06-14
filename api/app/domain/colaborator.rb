# frozen_string_literal: true

class Colaborator
  attr_accessor :custom_maps

  def initialize(custom_maps:)
    @custom_maps = custom_maps
  end

  def to_hash
    {
      custom_maps:
    }
  end
end
