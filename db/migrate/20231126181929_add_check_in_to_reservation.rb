class AddCheckInToReservation < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :checked_in_datetime, :datetime
    add_column :reservations, :checked_out_datetime, :datetime
  end
end
