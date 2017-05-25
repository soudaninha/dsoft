class CreateLicences < ActiveRecord::Migration
  def change
    create_table :licences do |t|
      t.references :client, index: true, foreign_key: true
      t.string :serial_bios
      t.string :type_licence
      t.decimal :price

      t.timestamps null: false
    end
  end
end
