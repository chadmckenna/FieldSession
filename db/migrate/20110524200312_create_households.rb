class CreateHouseholds < ActiveRecord::Migration
  def self.up
    create_table :households do |t|
      t.string :name
      t.integer :credits
      t.timestamps
    end
  end

  def self.down
    drop_table :households
  end
end
