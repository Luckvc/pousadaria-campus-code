class CreateConsumables < ActiveRecord::Migration[7.1]
  def change
    create_table :consumables do |t|
      t.string :description
      t.decimal "price", precision: 8, scale: 10
      t.references :reservation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
