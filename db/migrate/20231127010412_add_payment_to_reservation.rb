class AddPaymentToReservation < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :payment_method, :string
    add_column :reservations, :paid, :boolean, default: false
  end
end
