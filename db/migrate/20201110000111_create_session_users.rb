class CreateSessionUsers < ActiveRecord::Migration
  def change
    create_table :session_users do |t|
      t.references :user, index: true
      t.integer :session_limit

      t.timestamps
    end
  end
end
