class AddRcallToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rcall, :boolean
  end
end
