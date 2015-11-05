require 'test_helper'

class InvestmentsControllerTest < ActionController::TestCase
  test "Get Investment" do
   p = InvestmentsController.new.getLivePrice("AAPL")
  end
end
