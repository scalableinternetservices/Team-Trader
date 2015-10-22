require 'test_helper'

class RailsExtensionsTest < ActiveSupport::TestCase
  def test_array_mean
    assert_equal 18.75, [17, 22, 12, 24].mean
  end
  
  def test_array_mean_0
    assert_equal 0, [0, 0, 0, 0].mean
  end
end
