class RemoveUsersFromReservation < ActiveRecord::Migration[7.1]
  def change
    remove_reference :reservations, :user, null: false, foreign_key: true
  end
end
