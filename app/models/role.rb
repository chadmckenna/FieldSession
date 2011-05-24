class Role < ActiveRecord::Base
  attr_accessible :name, :description, :users_count
end
