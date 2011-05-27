class Request < ActiveRecord::Base
  attr_accessible :from_date, :start_time, :end_time, :cost, :to_date
  
  has_many :children
  belongs_to :user

  validates_presence_of :cost
  validates_numericality_of :cost
  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :from_date
  validates_presence_of :to_date
  
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

