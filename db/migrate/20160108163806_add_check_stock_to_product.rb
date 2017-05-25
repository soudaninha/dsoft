class AddCheckStockToProduct < ActiveRecord::Migration
  def change
    add_column :products, :check_stock, :boolean
  end
end
