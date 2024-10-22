# frozen_string_literal: true

module Domain
  class UserRepository
    attr_accessor :repository

    def initialize(repository:)
      @repository = repository
    end

    def create!(user)
      created_user = repository.create!(user)

      Domain::User.new(
        id: created_user.id,
        name: created_user.name,
        password: created_user.password,
        created_at: created_user.created_at,
        updated_at: nil
      )
    end

    def update!(user)
      repository.update!(user)
    end

    def delete!(id:)
      repository.delete!(id:)
    end

    def lookup!(id:)
      user = repository.lookup!(id:)

      Domain::User.new(
        id: user.id,
        name: user.name,
        password: user.password,
        created_at: user.created_at,
        updated_at: user.updated_at
      )
    end

    def get_all!(paginator:)
      users = repository.get_all!(paginator:)

      users.map do |user|
        Domain::User.new(
          id: user.id,
          name: user.name,
          password: user.password,
          created_at: user.created_at,
          updated_at: user.updated_at
        )
      end
    end
  end
end
