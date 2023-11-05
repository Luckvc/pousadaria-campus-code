class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :number
      t.string :description
      t.integer :double_beds
      t.integer :single_beds
      t.integer :capacity
      t.integer :price_cents
      t.integer :bathrooms
      t.boolean :kitchen
      t.references :inn, null: false, foreign_key: true

      t.timestamps
    end
  end
end
