class Request < ActiveRecord::Base
  attr_accessible :date, :start_time, :end_time, :cost

  has_many :children
  belongs_to :household

  validates_presence_of :cost

  before_create :assign_household

  protected
    def assign_household
      self.household = user.household if self.household.nil?
    end
end

