class CreateCallcenters < ActiveRecord::Migration
  def change
    create_table :callcenters do |t|
      t.references :client, index: true, foreign_key: true
      t.string :employee
      t.text :problem
      t.text :solution
      t.date :date_finish

      t.timestamps null: false
    end
  end
end
