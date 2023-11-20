class AddDefaultToRoom < ActiveRecord::Migration[7.1]
  def change
    change_column :rooms, :kitchen, :boolean, default: false
  end
end
