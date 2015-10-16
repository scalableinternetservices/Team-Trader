require 'test_helper'

class ChartsControllerTest < ActionController::TestCase
  test "should get PLChart" do
    get :PLChart
    assert_response :success
  end

end
