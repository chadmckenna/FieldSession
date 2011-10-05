class CreateChildren < ActiveRecord::Migration
  def self.up
    create_table :children do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.string :dietary_restrictions
      t.string :allergies
      t.string :medications
      t.string :notes
      t.integer :household_id
      t.timestamps
    end
  end

  def self.down
    drop_table :children
  end
end
