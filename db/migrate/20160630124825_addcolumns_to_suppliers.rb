class AddcolumnsToSuppliers < ActiveRecord::Migration
  def change
    add_column(:suppliers, :cidade_id, :string)
    add_column(:suppliers, :estado_id, :string)
  end
end
