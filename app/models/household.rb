class Household < ActiveRecord::Base
  attr_accessible :name, :credits

  has_many :children
  has_many :users

  def to_s
    self.name
  end
end
