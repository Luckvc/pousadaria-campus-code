class AddInnRefToUser < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :inn, null: true, foreign_key: true
  end
end
