class ChangeCheckinType < ActiveRecord::Migration[7.1]
  def change
    change_column :reservations, :check_in_date, :date
    change_column :reservations, :check_out_date, :date
    change_column :pre_reservations, :check_in_date, :date
    change_column :pre_reservations, :check_out_date, :date
  end
end
