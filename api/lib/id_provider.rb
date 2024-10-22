# frozen_string_literal: true

require "uuid"

class IdProvider
  def initialize
    @next_id = UUID.new.generate
  end

  attr_reader :next_id
end
