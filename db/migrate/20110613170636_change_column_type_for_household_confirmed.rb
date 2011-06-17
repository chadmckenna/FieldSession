class ChangeColumnTypeForHouseholdConfirmed < ActiveRecord::Migration
  def self.up
    #add_column :users, :convert_household_confirmed, :boolean, :default => false
    
    #User.reset_column_information
    #User.all.each do |u|
    #  u.convert_household_confirmed = u.household_confirmed == '1'
    #  u.save
    end
    
    #remove_column :users, :household_confirmed
    #rename_column :users, :convert_household_confirmed, :household_confirmed
  end

  def self.down
  	change_column :users, :household_confirmed, :string
  end
end
