# frozen_string_literal: true

require './app/adapters/repositories/user_repository'

def repositories
  {
    user_repository: UserRepository
  }
end
