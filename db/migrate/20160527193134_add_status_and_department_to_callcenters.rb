class AddStatusAndDepartmentToCallcenters < ActiveRecord::Migration
  def change
    add_column :callcenters, :department, :string
    add_column :callcenters, :status, :string
  end
end
