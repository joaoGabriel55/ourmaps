module Factories
  class UserFactory
    def self.build(user)
      Domain::User.new(
        id: user.id,
        name: user.name,
        email: user.email,
        password: user.password || "password_encrypted",
        created_at: user.created_at,
        updated_at: user.updated_at
      )
    end
  end
end
