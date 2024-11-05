class CustomMapsController < ApplicationController
  def index
    return render json: { error: "owner_id is required" }, status: 400 if check_owner_id

    lookup_owner.call

    get_all = UseCases::CustomMaps::GetAll.new(
      owner_id: params[:owner_id],
      repository_adapter: custom_map_repository,
      paginator: { per_page: params[:per_page], page: params[:page] }
    )

    @maps = get_all.call

    render json: @maps
  rescue UseCases::Users::NotFoundError => e
    render json: { error: e.message }, status: 404
  rescue UseCases::CustomMaps::GetAllError => e
    render json: { error: e.message }, status: 500
  end

  def create
    owner = lookup_owner.call

    create = UseCases::CustomMaps::Create.new(
      params: {
        name: params[:name],
        description: params[:description],
        owner:
      },
      repository_adapter: custom_map_repository,
    )

    @map = create.call

    render json: @map, status: 201
  rescue UseCases::Users::NotFoundError => e
    render json: { error: e.message }, status: 404
  rescue UseCases::CustomMaps::CreateError => e
    render json: { error: e.message }, status: 500
  end

  private

  def check_owner_id
    params[:owner_id].nil? || params[:owner_id].empty?
  end

  def custom_map_repository
    Domain::CustomMapRepository.new(repository: CustomMapRepository)
  end

  def user_repository
    Domain::UserRepository.new(repository: UserRepository)
  end

  def lookup_owner
    UseCases::Users::Lookup.new(id: params[:owner_id], repository_adapter: user_repository)
  end
end
