class ChangePriceInRoom < ActiveRecord::Migration[7.1]
  def change
    change_column :rooms, :price_cents, :decimal, :precision => 8, :scale => 10
    rename_column :rooms, :price_cents, :price
  end
end
