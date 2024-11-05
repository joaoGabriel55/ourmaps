# frozen_string_literal: true

class UserRepository < ApplicationRecord
  self.table_name = "users"

  has_and_belongs_to_many :custom_maps, class_name: "CustomMapRepository"

  def self.get_all!(paginator:)
    paginate(per_page: paginator[:per_page], page: paginator[:page])
  end

  def self.lookup!(id:)
    find(id)
  rescue ActiveRecord::RecordNotFound
    raise UseCases::Users::NotFoundError, "User not found: #{id}"
  end

  def self.update!(user)
    find(user[:id]).update!(user)
  rescue ActiveRecord::RecordNotFound
    raise UseCases::Users::UpdateError, "User not found: #{user[:id]}"
  end

  def self.delete!(id:)
    # NOTE: This will delete the user and all of its custom maps (?)
    delete(id)
  end
end
