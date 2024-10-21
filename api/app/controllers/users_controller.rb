class UsersController < ApplicationController
  def index
    @users = []

    render json: @users
  end

  def show
    lookup = UseCases::Users::Lookup.new(
      id: params[:id],
      repository_adapter: Domain::UserRepository.new(
        repository: UserRepository
      )
    )

    @user = lookup.call

    render json: @user
  end
end
