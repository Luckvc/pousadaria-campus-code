class AddStatusToReservation < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :status, :integer, default: 2
  end
end
