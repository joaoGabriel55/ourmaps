# frozen_string_literal: true

require './app/adapters/user_repository'

module Domain
  class UserRepository
    attr_accessor :repository

    def initialize(repository:)
      @repository = repository
    end

    delegate :create!, to: :repository
  end
end
