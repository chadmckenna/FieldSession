class Request < ActiveRecord::Base
  attr_accessible :date, :start_time, :end_time, :cost
end
