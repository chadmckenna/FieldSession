class AddHouseholdIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :household_id, :integer
  end

  def self.down
    remove_column :users, :household_id
  end
end
