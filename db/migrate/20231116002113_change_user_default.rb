class ChangeUserDefault < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :host, :boolean, default: true
  end
end
