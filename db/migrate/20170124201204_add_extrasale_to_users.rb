class AddExtrasaleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cextra_sale, :boolean
  end
end
