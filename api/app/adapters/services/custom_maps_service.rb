# frozen_string_literal: true

require_relative '../../usecases/custom_maps/create'
require_relative '../../usecases/custom_maps/get_all'
require_relative '../../usecases/custom_maps/lookup'
require_relative '../../usecases/custom_maps/update'
require_relative '../../usecases/custom_maps/delete'
require_relative '../../shared_kernel/id_provider'

class CustomMapsService
  def initialize(repository:)
    @repository_adapter = repository
  end

  attr_reader :repository_adapter

  def create(params:)
    params[:id] = IdProvider.new.next_id

    Usecases::CustomMaps::Create.new(params:, repository_adapter:).call
  end
end
