class Household < ActiveRecord::Base
  attr_accessible :name, :credits

  has_many :children
  has_many :users

  before_create :assign_default_credits
  
  protected
    
    def assign_default_credits
      self.credits = 0 if self.credits.nil?
    end
end
