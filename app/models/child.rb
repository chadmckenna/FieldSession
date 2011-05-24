class Child < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :date_of_birth, :dietary_restrictions, :allergies, :medications, :notes
end
