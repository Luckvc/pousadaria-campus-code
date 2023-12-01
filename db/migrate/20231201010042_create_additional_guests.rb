class CreateAdditionalGuests < ActiveRecord::Migration[7.1]
  def change
    create_table :additional_guests do |t|
      t.string :name
      t.string :document
      t.references :reservation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
