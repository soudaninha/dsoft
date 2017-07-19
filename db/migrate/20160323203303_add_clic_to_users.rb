class AddClicToUsers < ActiveRecord::Migration
  def change
    add_column :users, :clic, :boolean
  end
end
