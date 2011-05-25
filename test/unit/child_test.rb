require 'test_helper'

class ChildTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Child.new.valid?
  end
end
