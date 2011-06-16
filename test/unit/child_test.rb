require 'test_helper'

class ChildTest < ActiveSupport::TestCase
  def test_should_be_valid
    bob = children(:bob)
    sue = children(:sue)
    assert_equal bob.first_name, "Bob"
    assert_equal sue.medications, "pepper spray"
  end
end
