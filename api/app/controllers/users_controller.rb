class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]

  def index
    get_all = UseCases::Users::GetAll.new(
      adapter: repository,
      query: params[:query],
      paginator: {per_page: params[:per_page], page: params[:page]}
    )

    @users = get_all.call.map do |user|
      user.response
    end

    render json: @users
  rescue UseCases::Users::GetAllError => e
    render json: {error: e.message}, status: 500
  end

  def show
    @user = lookup.call

    render json: @user.response
  rescue UseCases::Users::NotFoundError => e
    render json: {error: e.message}, status: 404
  rescue UseCases::Users::LookupError => e
    render json: {error: e.message}, status: 500
  end

  def create
    create = UseCases::Users::Create.new(
      params: {
        id: params[:id],
        name: params[:name],
        email: params[:email],
        password: params[:password]
      },
      adapter: repository
    )

    @user = create.call

    render json: @user.response, status: 201
  rescue UseCases::Users::CreateError => e
    render json: {error: e.message}, status: 500
  end

  def update
    user = lookup.call

    user_params = user.to_hash.merge({
      name: params[:name],
      email: params[:email],
      password: params[:password]
    })

    update = UseCases::Users::Update.new(
      params: user_params,
      adapter: repository
    )

    update.call

    render status: 204
  rescue UseCases::Users::NotFoundError => e
    render json: {error: e.message}, status: 404
  rescue UseCases::Users::UpdateError => e
    render json: {error: e.message}, status: 500
  end

  def destroy
    lookup.call

    UseCases::Users::Delete.new(id: params[:id], adapter: repository).call

    render status: 204
  rescue UseCases::Users::NotFoundError => e
    render json: {error: e.message}, status: 404
  rescue UseCases::Users::DeleteError => e
    render json: {error: e.message}, status: 500
  end

  private

  def repository
    Domain::UserRepository.new(adapter: UserRepository)
  end

  def lookup
    UseCases::Users::Lookup.new(id: params[:id], adapter: repository)
  end
end
