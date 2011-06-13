class AddHouseholdConfirmed < ActiveRecord::Migration
  def self.up
    add_column :users, :household_confirmed, :string, :default => false
  end

  def self.down
    remove_column :users, :household_confirmed
  end
end