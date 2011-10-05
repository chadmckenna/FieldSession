class CreateEmergencyContacts < ActiveRecord::Migration
  def self.up
    create_table :emergency_contacts do |t|
      t.integer :household_id
      t.text :name
      t.string :phone
      t.text :relationship

      t.timestamps
    end
  end

  def self.down
    drop_table :emergency_contacts
  end
end
