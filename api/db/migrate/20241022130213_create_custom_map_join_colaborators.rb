class CreateCustomMapJoinCollaborators < ActiveRecord::Migration[7.2]
  def change
    create_table :custom_maps_users do |t|
      t.references :custom_map, foreign_key: true, type: :uuid
      t.references :collaborator, foreign_key: { to_table: :users }, type: :uuid

      t.timestamps
    end
  end
end
