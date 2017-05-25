class AddCcallToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ccall, :boolean
  end
end
