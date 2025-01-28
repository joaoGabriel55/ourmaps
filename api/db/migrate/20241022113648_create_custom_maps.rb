class CreateCustomMaps < ActiveRecord::Migration[7.2]
  def change
    create_table :custom_maps, id: :uuid do |t|
      t.string :name
      t.string :description
      t.jsonb :content

      t.references :owner, foreign_key: {to_table: :users}, type: :uuid

      t.timestamps
    end
  end
end
