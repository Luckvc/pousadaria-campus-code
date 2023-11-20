class AddAtributesToInn < ActiveRecord::Migration[7.1]
  def change
    add_column :inns, :policies, :string
    add_column :inns, :check_in_time, :string, default: "14:00"
    add_column :inns, :check_out_time, :string, default: "12:00"
    add_column :inns, :pix, :boolean, default: false
    add_column :inns, :credit, :boolean, default: false
    add_column :inns, :debit, :boolean, default: false
    add_column :inns, :cash, :boolean, default: false
  end
end
