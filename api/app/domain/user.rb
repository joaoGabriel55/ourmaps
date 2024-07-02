# frozen_string_literal: true

require './app/shared_kernel/id_provider'
require './app/domain/owner'
require './app/domain/colaborator'

module Domain
  class InvalidUser < StandardError; end

  class User
    attr_accessor :id, :name, :password, :owner, :colaborator, :created_at, :updated_at

    def initialize(name: nil, password: nil, owner: nil, colaborator: nil)
      validate(name:, password:)

      @id = IdProvider.next_id
      @name = name
      @password = password
      @owner = owner
      @colaborator = colaborator
      @created_at = DateTime.now
      @updated_at = nil
    end

    def to_hash
      {
        id:,
        name:,
        password:,
        owner:,
        colaborator:,
        created_at:,
        updated_at:
      }
    end

    private

    def validate(name:, password:)
      raise InvalidUser unless name && password
    end
  end
end
