class CreateCustomDates < ActiveRecord::Migration[7.1]
  def change
    create_table :custom_dates do |t|
      t.date :begin
      t.date :end
      t.integer :price_cents
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
