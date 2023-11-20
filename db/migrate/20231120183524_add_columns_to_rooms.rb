class AddColumnsToRooms < ActiveRecord::Migration[7.1]
  def change
    add_column :rooms, :dimenson, :integer, default: 0
    add_column :rooms, :balcony, :boolean, default: false
    add_column :rooms, :air, :boolean, default: false
    add_column :rooms, :tv, :boolean, default: false
    add_column :rooms, :wardrobe, :boolean, default: false
    add_column :rooms, :safe, :boolean, default: false
    add_column :rooms, :accessible, :boolean, default: false
  end
end
