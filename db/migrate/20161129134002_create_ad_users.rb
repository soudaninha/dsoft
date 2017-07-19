class CreateAdUsers < ActiveRecord::Migration
  def change
    create_table :ad_users do |t|
      t.string :colaborador
      t.string :departamento
      t.string :user_ad
      t.string :senha
      t.string :ip
      t.text :pastas

      t.timestamps null: false
    end
  end
end
