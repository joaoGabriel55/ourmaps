class UsersController < ApplicationController
  def index
    get_all = UseCases::Users::GetAll.new(
      repository_adapter: repository,
      paginator: { per_page: params[:per_page], page: params[:page] }
    )

    @users = get_all.call

    render json: @users
  rescue UseCases::Users::GetAllError => e
    render json: { error: e.message }, status: 500
  end

  def show
    @user = lookup.call

    render json: @user.response
  rescue UseCases::Users::NotFoundError => e
    render json: { error: e.message }, status: 404
  rescue UseCases::Users::LookupError => e
    render json: { error: e.message }, status: 500
  end

  def create
    create = UseCases::Users::Create.new(
      params: {
        id: params[:id],
        name: params[:name],
        password: params[:password]
      },
      repository_adapter: repository
    )

    @user = create.call

    render json: @user.response, status: 201
  rescue UseCases::Users::CreateError => e
    render json: { error: e.message }, status: 500
  end

  def update
    user = lookup.call

    user_params = user.to_hash.merge({
      name: params[:name],
      password: params[:password]
    })

    update = UseCases::Users::Update.new(
      params: user_params,
      repository_adapter: repository
    )

    update.call

    render status: 204
  rescue UseCases::Users::NotFoundError => e
    render json: { error: e.message }, status: 404
  rescue UseCases::Users::UpdateError => e
    render json: { error: e.message }, status: 500
  end

  def destroy
    lookup.call

    destroy = UseCases::Users::Delete.new(id: params[:id], repository_adapter: repository)

    destroy.call

    render status: 204
  rescue UseCases::Users::NotFoundError => e
    render json: { error: e.message }, status: 404
  rescue UseCases::Users::DeleteError => e
    render json: { error: e.message }, status: 500
  end

  private

  def repository
    Domain::UserRepository.new(repository: UserRepository)
  end

  def lookup
    UseCases::Users::Lookup.new(id: params[:id], repository_adapter: repository)
  end
end
