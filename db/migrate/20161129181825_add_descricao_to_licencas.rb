class AddDescricaoToLicencas < ActiveRecord::Migration
  def change
    add_column :licencas, :descricao, :string
  end
end
