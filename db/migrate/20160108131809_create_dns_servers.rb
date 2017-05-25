class CreateDnsServers < ActiveRecord::Migration
  def change
    create_table :dns_servers do |t|
      t.string :email
      t.string :password
      t.string :dns
      t.references :client, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
