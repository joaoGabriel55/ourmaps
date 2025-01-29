# frozen_string_literal: true

module UseCases
  module Users
    class GetAllError < StandardError; end

    class GetAll
      attr_accessor :query, :paginator, :user_repository

      def initialize(
        adapter:,
        query: nil,
        paginator: {per_page: 10, page: 1}
      )
        @query = query
        @paginator = paginator
        @user_repository = Domain::UserRepository.new(adapter:)
      end

      def call
        user_repository.get_all!(query:, paginator:)
      rescue => e
        LoggerProvider.new.error(e)
        raise GetAllError, "Error fetching users"
      end
    end
  end
end
