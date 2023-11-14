class AddPetsToInn < ActiveRecord::Migration[7.1]
  def change
    add_column :inns, :pets, :boolean, default: false
  end
end
