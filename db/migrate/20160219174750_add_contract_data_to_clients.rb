class AddContractDataToClients < ActiveRecord::Migration
  def change
    add_column :clients, :status, :string
    add_column :clients, :description, :string
    add_column :clients, :value, :decimal
    add_column :clients, :due_date, :date
    add_column :clients, :obs, :string
    add_column :clients, :filename, :string
    add_column :clients, :content_type, :string
    add_column :clients, :file_contents, :binary
  end
end
