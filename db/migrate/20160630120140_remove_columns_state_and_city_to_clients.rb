class RemoveColumnsStateAndCityToClients < ActiveRecord::Migration
  def change
    remove_column :clients, :state
    remove_column :clients, :city
  end
end
