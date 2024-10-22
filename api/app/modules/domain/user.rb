# frozen_string_literal: true

module Domain
  class InvalidUser < StandardError; end

  class User
    attr_accessor :id, :name, :password, :created_at, :updated_at

    def initialize(id: nil, name: nil, password: nil, created_at: nil, updated_at: nil)
      validate(name:, password:)

      @id = id
      @name = name
      @password = password
      @created_at = created_at || DateTime.now
      @updated_at = updated_at || nil
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

    def response
      to_hash
        .except(:password)
        .transform_keys(&:to_s)
        .deep_transform_keys! { |key| key.camelize(:lower) }
    end

    private

    def validate(name:, password:)
      if name.nil?
        raise InvalidUser, "name is required"
      elsif password.nil?
        raise InvalidUser, "password is required"
      elsif password.length < 6
        raise InvalidUser, "password must be at least 6 characters long"
      end
    end
  end
end
