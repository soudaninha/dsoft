class AddStatusToLicencas < ActiveRecord::Migration
  def change
    add_column :licencas, :status, :string
  end
end
