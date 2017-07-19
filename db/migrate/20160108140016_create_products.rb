class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :qnt
      t.decimal :cost_value
      t.decimal :cost_sale
      t.references :supplier, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
