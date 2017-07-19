class AddPainelServprojectToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mpainel_servproject, :boolean
  end
end
