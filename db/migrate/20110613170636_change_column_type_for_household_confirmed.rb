class ChangeColumnTypeForHouseholdConfirmed < ActiveRecord::Migration
  def self.up
  	change_table :users do |t|
      t.change :household_confirmed, :boolean
    end
  end

  def self.down
  	change_table :users do |t|
      t.change :household_confirmed, :string
    end
  end
end
