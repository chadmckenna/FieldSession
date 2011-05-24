require 'test_helper'

class HouseholdTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Household.new.valid?
  end
end
