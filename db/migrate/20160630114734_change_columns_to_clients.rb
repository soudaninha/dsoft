class ChangeColumnsToClients < ActiveRecord::Migration
  def change
    remove_column(:clients, :cidade_id)
    remove_column(:clients, :estado_id)
    
  end
end
