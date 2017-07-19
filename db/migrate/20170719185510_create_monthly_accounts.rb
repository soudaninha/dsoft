class CreateMonthlyAccounts < ActiveRecord::Migration
  def change
    create_table :monthly_accounts do |t|
      t.date :due_date
      t.string :description

      t.timestamps null: false
    end
  end
end
