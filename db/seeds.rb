# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
Role.create!(:name => 'developer', :description => 'The system developer. There is no higher access level.')
Role.create!(:name => 'administrator', :description => 'A system administrator. Full access to all features.')
Role.create!(:name => 'member', :description => 'A typical application user.')

#User.create!(:username => "bmakuh", :email => "bmakuh@mines.edu", :password => "changeme", :password_confirmation => "changeme", :first_name => "Ben", :last_name => "Makuh", :household => Household.new(:name => "Makuh", :credits => 2000), :role_id => 1)

