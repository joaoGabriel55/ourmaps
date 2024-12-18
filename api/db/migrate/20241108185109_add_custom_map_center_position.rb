class AddCustomMapCenterPosition < ActiveRecord::Migration[7.2]
  def change
    add_column :custom_maps, :lat_center, :float
    add_column :custom_maps, :lng_center, :float
  end
end
