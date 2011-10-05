class AddBelongsToHouseholdIdToPendingRequests < ActiveRecord::Migration
  def self.up
    add_column :pending_requests, :belongs_to_household_id, :integer
  end

  def self.down
    remove_column :pending_requests, :belongs_to_household_id
  end
end
