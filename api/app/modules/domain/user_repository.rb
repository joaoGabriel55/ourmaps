# frozen_string_literal: true

module Domain
  class UserRepository
    attr_accessor :repository

    def initialize(repository:)
      @repository = repository
    end

    def create!(user)
      repository.create!(user)
    end

    def update!(user)
      repository.update!(user)
    end

    def delete!(id:)
      repository.delete!(id:)
    end

    def lookup!(id:)
      user = repository.lookup!(id:)

      user unless user.nil?
    end

    def lookup_by_email!(email:)
      user = repository.lookup_by_email!(email: email)

      user unless user.nil?
    end

    def get_all!(paginator:)
      repository.get_all!(paginator:)
    end
  end
end
