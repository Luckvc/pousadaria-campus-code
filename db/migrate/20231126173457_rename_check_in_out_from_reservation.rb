class RenameCheckInOutFromReservation < ActiveRecord::Migration[7.1]
  def change
    rename_column :reservations, :check_in_date, :checkin_expected_date
    rename_column :reservations, :check_out_date, :checkout_expected_date
    rename_column :pre_reservations, :check_in_date, :checkin_expected_date
    rename_column :pre_reservations, :check_out_date, :checkout_expected_date
  end
end
