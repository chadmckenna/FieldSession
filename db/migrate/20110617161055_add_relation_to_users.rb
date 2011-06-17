class AddRelationToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :relationship, :string
  end

  def self.down
    remove_column :users, :relationship
  end
end
