# frozen_string_literal: true

module Domain
  class UserRepository
    attr_accessor :adapter

    def initialize(adapter:)
      @adapter = adapter
    end

    def create!(user)
      adapter.create!(user)
    end

    def update!(user)
      adapter.update!(user)
    end

    def delete!(id:)
      adapter.delete!(id:)
    end

    def lookup!(id:)
      user = adapter.lookup!(id:)

      user unless user.nil?
    end

    def lookup_by_email!(email:)
      user = adapter.lookup_by_email!(email: email)

      user unless user.nil?
    end

    def get_all!(query:, paginator:)
      adapter.get_all!(query:, paginator:)
    end
  end
end
