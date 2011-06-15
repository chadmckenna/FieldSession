class AddIsCompletedColumnToRequests < ActiveRecord::Migration
  def self.up
    add_column :requests, :is_completed, :boolean, :default => false
  end

  def self.down
    remove_column :requests, :is_completed
  end
end
