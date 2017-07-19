class AddPerfilToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ccli, :boolean
    add_column :users, :cforn, :boolean
    add_column :users, :cpat, :boolean
    add_column :users, :cprod, :boolean
    add_column :users, :cservidor, :boolean
    add_column :users, :cuser, :boolean
    add_column :users, :mos, :boolean
    add_column :users, :fpag, :boolean
    add_column :users, :frec, :boolean
    add_column :users, :rcli, :boolean
    add_column :users, :rforn, :boolean
    add_column :users, :rpat, :boolean
    add_column :users, :rprod, :boolean
    add_column :users, :rpag, :boolean
    add_column :users, :rrec, :boolean
  end
end
