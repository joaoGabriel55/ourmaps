# frozen_string_literal: true

require './app/shared_kernel/id_provider'
require './app/domain/owner'
require './app/domain/colaborator'

module Domain
  class InvalidUser < StandardError; end

  class User
    attr_accessor :id, :name, :password, :created_at, :updated_at

    def initialize(id: nil, name: nil, password: nil)
      validate(name:, password:)

      @id = id || IdProvider.next_id
      @name = name
      @password = password
      @created_at = DateTime.now
      @updated_at = nil
    end

    def to_hash
      {
        id:,
        name:,
        password:,
        created_at:,
        updated_at:
      }
    end

    private

    def validate(name:, password:)
      if name.nil?
        raise InvalidUser, 'Name is required'
      elsif password.nil?
        raise InvalidUser, 'Password is required'
      elsif password.length < 6
        raise InvalidUser, 'Password must be at least 6 characters long'
      end
    end
  end
end
