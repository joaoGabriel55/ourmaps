# frozen_string_literal: true

module Domain
  class UserRepository
    attr_accessor :repository

    def initialize(repository:)
      @repository = repository
    end

    delegate :create!, to: :repository
    delegate :update!, to: :repository
    delegate :delete!, to: :repository

    def delete!(id:)
      repository.delete!(id:)
    end

    def lookup!(id:)
      repository.lookup!(id:)
    end

    def get_all!(paginator:)
      repository.get_all!(paginator:)
    end
  end
end
