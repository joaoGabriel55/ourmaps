# frozen_string_literal: true

module Domain
  class InvalidUser < StandardError; end

  class User
    attr_accessor :id, :name, :email, :password, :created_at, :updated_at

    def initialize(id: nil, name: nil, email: nil, password: nil, created_at: nil, updated_at: nil)
      validate(id:, name:, email:, password:)

      @id = id
      @name = name
      @email = email
      @password = password
      @created_at = created_at || DateTime.now
      @updated_at = updated_at || nil
    end

    def to_hash
      {
        id:,
        name:,
        email:,
        password:,
        created_at:,
        updated_at:
      }
    end

    def response
      {
        id:,
        name:,
        email:,
        created_at:,
        updated_at:
      }
    end

    private

    def validate(id:, name:, email:, password:)
      if id.nil?
        raise InvalidUser, "id is required"
      elsif name.nil?
        raise InvalidUser, "name is required"
      elsif email.nil?
        raise InvalidUser, "email is required"
      elsif password.nil?
        raise InvalidUser, "password is required"
      elsif password.length < 6
        raise InvalidUser, "password must be at least 6 characters long"
      end
    end
  end

  class UserDTO
  end
end
