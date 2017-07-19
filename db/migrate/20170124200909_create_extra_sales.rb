class CreateExtraSales < ActiveRecord::Migration
  def change
    create_table :extra_sales do |t|
      t.references :client, index: true, foreign_key: true
      t.string :product
      t.decimal :value
      t.date :due_date
      t.text :obs

      t.timestamps null: false
    end
  end
end
