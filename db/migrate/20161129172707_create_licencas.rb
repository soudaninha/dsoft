class CreateLicencas < ActiveRecord::Migration
  def change
    create_table :licencas do |t|
      t.string :produto
      t.string :serial
      t.references :patrimonio, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
