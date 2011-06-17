class AddHouseholdConfirmed < ActiveRecord::Migration
  def self.up
    add_column :users, :household_confirmed, :boolean, :default => false
  end

  def self.down
    remove_column :users, :household_confirmed
  end
end