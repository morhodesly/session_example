class CreateLogins < ActiveRecord::Migration
  def change
    create_table :logins do |t|
      t.belongs_to :user, index: true
      t.string :ip_address
      t.string :user_agent
      t.string :device_id

      t.timestamps
    end
    add_index :logins, :device_id
  end
end
