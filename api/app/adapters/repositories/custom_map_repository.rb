# frozen_string_literal: true

class CustomMapRepository < ActiveRecord::Base
  self.table_name = 'custom_maps'

  belongs_to :owner, class_name: 'UserRepository', foreign_key: :owner_id
  has_many :colaborators, class_name: 'UserRepository', foreign_key: :custom_map_id
end
