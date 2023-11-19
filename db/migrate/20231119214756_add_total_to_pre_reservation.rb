class AddTotalToPreReservation < ActiveRecord::Migration[7.1]
  def change
    add_column :pre_reservations, :total, :integer
  end
end
