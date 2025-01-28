class AddCustomMapVisibility < ActiveRecord::Migration[7.2]
  def change
    add_column :custom_maps, :visibility, :string, default: "public"
  end
end
