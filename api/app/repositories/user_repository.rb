# frozen_string_literal: true

class UserRepository
  def self.create!(user)
    created_user = User.create!(user)

    Factories::UserFactory.create(created_user)
  end

  def self.get_all!(paginator:)
    users = User.paginate(per_page: paginator[:per_page], page: paginator[:page])

    users.map do |user|
      Factories::UserFactory.create(user)
    end
  end

  def self.lookup!(id:)
    user = User.find(id)

    Factories::UserFactory.create(user)
  rescue ActiveRecord::RecordNotFound
    raise UseCases::Users::NotFoundError, "User not found: #{id}"
  end

  def self.lookup_by_email!(email:)
    user = User.find_by(email: email)

    Factories::UserFactory.create(user)
  rescue ActiveRecord::RecordNotFound
    raise UseCases::Users::NotFoundError, "User not found: #{email}"
  end

  def self.update!(user)
    User.find(user[:id]).update!(user)
  rescue ActiveRecord::RecordNotFound
    raise UseCases::Users::UpdateError, "User not found: #{user[:id]}"
  end

  def self.delete!(id:)
    # NOTE: This will delete the user and all of its custom maps (?)
    User.delete(id)
  end
end
