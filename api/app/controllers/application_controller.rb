class ApplicationController < ActionController::API
  before_action :authenticate_request

  private

  def authenticate_request
    header = request.headers["Authorization"]
    header = header.split(" ").last if header

    return render json: {error: "Missing token"}, status: :unauthorized unless header

    decoded = JsonWebToken.decode(header)

    return render json: {error: "Invalid token"}, status: :unauthorized unless decoded

    repository = Domain::UserRepository.new(adapter: UserRepository)

    @current_user = repository.lookup!(id: decoded[:user_id])
  end
end
