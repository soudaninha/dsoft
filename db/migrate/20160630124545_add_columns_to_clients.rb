class AddColumnsToClients < ActiveRecord::Migration
  def change
    add_column :clients, :cidade_id, :string
    add_column :clients, :estado_id, :string
  end
end
