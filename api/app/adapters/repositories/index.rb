# frozen_string_literal: true

require './app/adapters/repositories/user_repository'
require './app/adapters/repositories/custom_map_repository'

def repositories
  {
    user_repository: UserRepository,
    custom_map_repository: CustomMapRepository
  }
end
