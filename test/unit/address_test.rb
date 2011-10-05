require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert addresses(:one).valid?
  end
end
