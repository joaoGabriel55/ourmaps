# frozen_string_literal: true
module UseCases
  module Users
    class UpdateError < StandardError; end

    class Update
      attr_accessor :user_repository, :user, :params

      def initialize(params:, repository_adapter:, user: Domain::User)
        @params = params
        @user = user
        @user_repository = Domain::UserRepository.new(
          repository: repository_adapter
        )
      end

      def call
        updated_user = user.new(
          id: params[:id],
          name: params[:name],
          password: params[:password],
          updated_at: DateTime.now
        )

        user_repository.update!(updated_user.to_hash)

        updated_user.response
      rescue Domain::InvalidUser => e
        LoggerProvider.new.error(e)
        raise UpdateError, e.message
      rescue StandardError => e
        LoggerProvider.new.error(e)
        raise UpdateError, 'Error updating user'
      end
    end
  end
end
