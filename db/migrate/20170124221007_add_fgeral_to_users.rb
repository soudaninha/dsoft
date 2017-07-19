class AddFgeralToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fgeral, :boolean
  end
end
