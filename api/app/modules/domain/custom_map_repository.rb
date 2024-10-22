# frozen_string_literal: true

module Domain
  class CustomMapRepository
    attr_accessor :repository

    def initialize(repository:)
      @repository = repository
    end

    delegate :create!, to: :repository
    delegate :update!, to: :repository
    delegate :lookup!, to: :repository
    delegate :delete!, to: :repository

    def get_all!(owner_id:, paginator:)
      repository.get_all!(owner_id:, paginator:)
    end
  end
end
