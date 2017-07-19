class CreatePatrimonios < ActiveRecord::Migration
  def change
    create_table :patrimonios do |t|
      t.string :numero_patrimonio
      t.string :descricao
      t.references :ad_user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
