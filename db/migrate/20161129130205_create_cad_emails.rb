class CreateCadEmails < ActiveRecord::Migration
  def change
    create_table :cad_emails do |t|
      t.string :email
      t.string :senha_email
      t.string :skype
      t.string :senha_skype

      t.timestamps null: false
    end
  end
end
