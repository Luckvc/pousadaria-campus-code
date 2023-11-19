class CreatePreReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :pre_reservations do |t|
      t.datetime :check_in_date
      t.datetime :check_out_date
      t.integer :guests
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
