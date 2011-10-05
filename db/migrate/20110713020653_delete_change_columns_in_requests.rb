class DeleteChangeColumnsInRequests < ActiveRecord::Migration
  def self.up
    remove_column :requests, :is_completed
    rename_column :requests, :from_date, :start_date
    rename_column :requests, :to_date, :end_date
    rename_column :requests, :cost, :credits
  end

  def self.down
    rename_column :requests, :credits, :cost
    rename_column :requests, :end_date, :to_date
    rename_column :requests, :start_date, :from_date
    add_column :requests, :is_completed, :boolean
  end
end
