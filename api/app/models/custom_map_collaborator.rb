class CustomMapCollaborator < ApplicationRecord
  belongs_to :user
  belongs_to :custom_map
end
