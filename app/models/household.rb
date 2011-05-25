class Household < ActiveRecord::Base
  attr_accessible :name, :credits

  has_many :children
  has_many :users
end
