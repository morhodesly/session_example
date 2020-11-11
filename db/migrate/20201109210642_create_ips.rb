class CreateIps < ActiveRecord::Migration
  def change
    create_table :ips do |t|
      t.string :address
      t.string :country
      t.string :city

      t.timestamps
    end
    add_index :ips, :address
  end
end
