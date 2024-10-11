class UsersController < ApplicationController
  def index
    @users = [
    ]

    render json: @users
  end

  def show
    @user = Usecases::Users::Lookup.call(id: params[:id], repository_adapter: Domain::UserRepository.new)

    render json: @user
  end
end
