class Role < ActiveRecord::Base
  attr_accessible :name, :description, :users_count
  
  has_many :users
  
  def to_s
    self.name
  end
  
  def name=(name)
    self[:name] = name.strip.downcase
  end
  
end
