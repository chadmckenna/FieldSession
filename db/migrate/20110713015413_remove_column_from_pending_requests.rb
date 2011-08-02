class RemoveColumnFromPendingRequests < ActiveRecord::Migration
  def self.up
    remove_column :pending_requests, :read
    remove_column :pending_requests, :pending
  end

  def self.down
    add_column :pending_requests, :read, :string
    add_column :pending_requests, :pending, :string
  end
end
