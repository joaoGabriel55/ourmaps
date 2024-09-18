# frozen_string_literal: true

class CreateCustomMaps < ActiveRecord::Migration[7.1]
  def change
    create_table :custom_maps do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
