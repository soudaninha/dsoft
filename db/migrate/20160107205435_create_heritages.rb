class CreateHeritages < ActiveRecord::Migration
  def change
    create_table :heritages do |t|
      t.string :description
      t.string :type_contract
      t.references :client, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
