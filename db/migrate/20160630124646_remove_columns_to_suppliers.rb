class RemoveColumnsToSuppliers < ActiveRecord::Migration
  def change
    remove_column(:suppliers, :cidade_id)
    remove_column(:suppliers, :estado_id)
  end
end
