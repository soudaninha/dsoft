class AddCmonToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cmon, :boolean
  end
end
