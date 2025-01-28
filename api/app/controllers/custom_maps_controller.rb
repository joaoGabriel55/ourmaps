class CustomMapsController < ApplicationController
  def index
    return render json: { error: "owner_id is required" }, status: 400 if missing_owner_id?

    lookup_owner.call

    get_all = UseCases::CustomMaps::GetAll.new(
      owner_id: params[:owner_id],
      repository_adapter: custom_map_repository,
      filters: { visibility: params[:visibility] },
      paginator: { per_page: params[:per_page], page: params[:page] }
    )

    @maps = get_all.call.map do |map|
      map.to_hash
    end

    render json: @maps
  rescue UseCases::Users::NotFoundError => e
    render json: { error: e.message }, status: 404
  rescue UseCases::CustomMaps::GetAllError => e
    render json: { error: e.message }, status: 500
  rescue StandardError => e
    render json: { error: e.message }, status: 500
  end

  def show
    @map = lookup.call

    render json: @map.to_hash
  rescue UseCases::CustomMaps::NotFoundError => e
    render json: { error: e.message }, status: 404
  rescue UseCases::CustomMaps::NotMapOwnerError => e
    render json: { error: e.message }, status: 403
  rescue UseCases::CustomMaps::LookupError => e
    render json: { error: e.message }, status: 500
  end

  def create
    owner = lookup_owner.call

    create = UseCases::CustomMaps::Create.new(
      params: {
        name: params[:name],
        description: params[:description],
        owner:,
        center: params[:center],
        content: params[:content],
        visibility: params[:visibility]
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

  def update
    map = lookup.call

    update = UseCases::CustomMaps::Update.new(
      params: {
        id: params[:id],
        name: params[:name],
        description: params[:description],
        center: params[:center],
        content: params[:content],
        owner: map.owner,
        visibility: params[:visibility],
        created_at: map.created_at,
        updated_at: DateTime.now
      },
      repository_adapter: custom_map_repository,
    )

    @map = update.call

    render json: @map
  rescue UseCases::CustomMaps::NotFoundError => e
    render json: { error: e.message }, status: 404
  rescue UseCases::CustomMaps::NotMapOwnerError => e
    render json: { error: e.message }, status: 403
  rescue UseCases::CustomMaps::UpdateError => e
    render json: { error: e.message }, status: 500
  end

  def destroy
    map = lookup.call

    UseCases::CustomMaps::Delete.new(id: map.id, repository_adapter: custom_map_repository).call

    render status: 204
  rescue UseCases::CustomMaps::NotFoundError => e
    render json: { error: e.message }, status: 404
  rescue UseCases::CustomMaps::NotMapOwnerError => e
    render json: { error: e.message }, status: 403
  rescue UseCases::CustomMaps::DeleteError => e
    render json: { error: e.message }, status: 500
  end

  private

  def missing_owner_id?
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

  def lookup
    UseCases::CustomMaps::Lookup.new(
      id: params[:id],
      current_user_id: @current_user.id,
      repository_adapter: custom_map_repository
    )
  end
end
