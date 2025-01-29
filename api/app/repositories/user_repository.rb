# frozen_string_literal: true

class UserRepository
  def self.create!(user)
    created_user = User.create!(user)

    Factories::UserFactory.build(created_user)
  end

  def self.get_all!(query:, paginator:)
    users = if query.present?
      User.query_search(query).order(created_at: :desc)
    else
      User.paginate(per_page: paginator[:per_page], page: paginator[:page]).order(created_at: :desc)
    end

    users.map do |user|
      Factories::UserFactory.build(user)
    end
  end

  def self.lookup!(id:)
    user = User.find(id)

    Factories::UserFactory.build(user)
  rescue ActiveRecord::RecordNotFound
    raise UseCases::Users::NotFoundError, "User not found: #{id}"
  end

  def self.lookup_by_email!(email:)
    user = User.find_by(email: email)

    Factories::UserFactory.build(user)
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
