# frozen_string_literal: true

require './app/adapters/user_repository'

module Domain
  class UserRepository
    attr_accessor :repository

    def initialize(repository:)
      @repository = repository
    end

    def create!(user)
      repository.create!(user)
    end
  end
end
