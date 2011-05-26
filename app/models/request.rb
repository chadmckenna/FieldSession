class Request < ActiveRecord::Base
  attr_accessible :date, :start_time, :end_time, :cost

  has_many :children
  belongs_to :household

  validates_presence_of :cost
  validates_numericality_of :cost
  validates_is_after :date
  validates_is_after :start_time
  validates_is_after :end_time, :after => :start_time

  before_create :assign_household

  protected
    def assign_household
      self.household = @user.household if self.household.nil?
    end
end

