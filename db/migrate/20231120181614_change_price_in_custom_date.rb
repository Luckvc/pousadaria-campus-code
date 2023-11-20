class ChangePriceInCustomDate < ActiveRecord::Migration[7.1]
  def change
    change_column :custom_dates, :price_cents, :decimal, :precision => 8, :scale => 10
    rename_column :custom_dates, :price_cents, :price
  end
end
