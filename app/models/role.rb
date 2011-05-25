class Role < ActiveRecord::Base
  attr_accessible :name, :description, :users_count
  
  has_many :users
end
