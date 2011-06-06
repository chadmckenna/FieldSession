class Request < ActiveRecord::Base
  #attr_accessible :from_date, :start_time, :end_time, :cost, :to_date

  has_and_belongs_to_many :children
  belongs_to :household
  has_many :pending_requests
  has_many :hidden_requests

  #validates_presence_of :cost
  #validates_numericality_of :cost
  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :from_date
  validates_presence_of :to_date

  before_save :calculate_cost
  before_create :check_time

  def calculate_cost
    if self.from_date.eql?(self.to_date)
      @day_to_hours = 0
    else
      @days_to_hours = ((self.to_date - self.from_date)/1.hour)
    end
    self.cost = (((self.end_time - self.start_time)/1.hour)+ @days_to_hours.to_f).ceil#*4
  end
  
  def same_date
    if self.from_date.eql?(self.to_date)
      return true
    else
      return false
    end
  end
  
  def check_time
    for request in @my_requests
      if self.from_date >= request.from_date && self.to_date <= request.to_date
        if request.from_date == request.to_date
          if (self.start_time >= request.start_time && self.start_time <= request.end_time) || (self.end_time >= request.start_time && self.end_time <= request.end_time)
            errors.add_to_base "Invalid time selection: Same date error."
          end
        else
          errors.add_to_base "Invalid time selection: Cannot create request within a request."
        end
      elsif self.from_date <= request.to_date && self.to_date >= request.end_date
        errors.add_to_base "Invalid date selection: Cannot have requests overlap one another in the beginning"
      elsif self.from_date <= requeest.to_date && self.end_date >= request.end_date
        errors.add_to_base "Invalid date selection: Cannot have requests overlap one another in the end"
      end
      
    end
  end
          

  protected
    def validate
      if !self.from_date.nil? && !self.to_date.nil?
        if self.from_date == self.to_date
          errors.add_to_base "End time must be after start time" if self.start_time >= self.end_time
        elsif self.from_date > self.to_date
          errors.add_to_base "End date must be after start date"
        end
      end
    end
end

