class CreateCustomMapCollaborators < ActiveRecord::Migration[7.2]
  def change
    create_table :custom_map_collaborators do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :custom_map, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
