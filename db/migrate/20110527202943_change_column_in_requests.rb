class ChangeColumnInRequests < ActiveRecord::Migration
  def self.up
    rename_column :requests, :user_id, :household_id 
  end

  def self.down
    rename_column :requests, :household_id, :user_id
  end
end
