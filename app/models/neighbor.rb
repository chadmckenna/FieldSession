class Neighbor < ActiveRecord::Base
  belongs_to :neighbor, :class_name => 'Household'
  belongs_to :household
end
