class RenameDimensionInRooms < ActiveRecord::Migration[7.1]
  def change
    rename_column :rooms, :dimenson, :dimension
  end
end
