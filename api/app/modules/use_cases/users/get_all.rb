# frozen_string_literal: true

module UseCases
  module Users
    class GetAllError < StandardError; end

    class GetAll
      attr_accessor :paginator, :user_repository

      def initialize(repository_adapter:,
                     paginator: { per_page: 10, page: 1 })
        @paginator = paginator
        @user_repository = Domain::UserRepository.new(
          repository: repository_adapter
        )
      end

      def call
        user_repository.get_all!(paginator:)
      rescue StandardError => e
        LoggerProvider.new.error(e)
        raise GetAllError, "Error fetching users"
      end
    end
  end
end
