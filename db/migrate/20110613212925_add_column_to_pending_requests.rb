class AddColumnToPendingRequests < ActiveRecord::Migration
  def self.up
    add_column :pending_requests, :read, :string
  end

  def self.down
    remove_column :pending_requests, :read
  end
end
