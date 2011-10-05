class AddColumnToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :work_phone, :string
  end

  def self.down
    remove_column :users, :work_phone
  end
end
