class Request < ActiveRecord::Base
  attr_accessible :date, :start_time, :end_time, :cost

  has_many :children
  belongs_to :user

  validates_presence_of :cost
  validates_numericality_of :cost

end

