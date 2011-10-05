class ChangeColumnsInRequests < ActiveRecord::Migration
  def self.up
    rename_column :requests, :date, :from_date
    add_column :requests, :to_date, :datetime
  end

  def self.down
    remove_column :requests, :to_date
    rename_column :requests, :from_date, :date
  end
end
