# frozen_string_literal: true

require 'securerandom'

class IdProvider
  def self.next_id
    SecureRandom.uuid
  end
end
