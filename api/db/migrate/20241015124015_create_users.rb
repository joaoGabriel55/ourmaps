class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :id
      t.string :name
      t.string :password

      t.timestamps
    end
  end
end