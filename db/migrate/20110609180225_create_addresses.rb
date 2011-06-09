class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :street1, :null => false
      t.string :street2
      t.string :city, :null => false
      t.string :state, :null => false
      t.integer :zip, :null => false
      t.integer :household_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
