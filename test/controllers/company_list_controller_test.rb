require 'test_helper'

class CompanyListControllerTest < ActionController::TestCase
  test "should get getHints" do
    hash = {:query => 'AP'}
    get :getHints, hash
    assert_response :success
  end

end
