class AddValueDocToMonthlyAccounts < ActiveRecord::Migration
  def change
    add_column :monthly_accounts, :value_doc, :decimal
  end
end
