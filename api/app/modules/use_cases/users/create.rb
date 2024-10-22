# frozen_string_literal: true

module UseCases
  module Users
    class CreateError < StandardError; end

    class Create
      attr_accessor :user_repository, :params

      def initialize(params:, repository_adapter:)
        @params = params
        @user_repository = Domain::UserRepository.new(repository: repository_adapter)
      end

      def call
        new_user = Domain::User.new(
          id: IdProvider.new.next_id,
          name: params[:name],
          password: params[:password]
        )

        user_repository.create!(new_user.to_hash)
      rescue Domain::InvalidUser => e
        LoggerProvider.new.error(e)
        raise CreateError, e.message
      rescue StandardError => e
        LoggerProvider.new.error(e)
        raise CreateError, "Error creating user"
      end
    end
  end
end
