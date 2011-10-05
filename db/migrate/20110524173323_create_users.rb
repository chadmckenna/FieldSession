class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :persistence_token
      t.string :crypted_password
      t.string :password_salt
      t.string :phone
      t.integer :role_id
      t.string :first_name
      t.string :last_name
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
