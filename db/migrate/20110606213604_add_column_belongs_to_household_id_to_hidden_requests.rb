class AddColumnBelongsToHouseholdIdToHiddenRequests < ActiveRecord::Migration
  def self.up
    add_column :hidden_requests, :belongs_to_household_id, :integer
  end

  def self.down
    remove_column :hidden_requests, :belongs_to_household_id
  end
end
