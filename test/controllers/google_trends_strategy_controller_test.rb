require 'test_helper'

class GoogleTrendsStrategyControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    hash = {:start_date=>'2014-04-20', :end_date=>'2014-07-05', :collapse => 'weekly', :stock_symbol => 'INDEX_DJI', :trend_term =>'GOOG'}
        # start_date=2014-04-20&end_date=2014-07-10&collapse=weekly&ticker=INDEX_DJI
    get(:show, hash)
    assert_response :success
  end

end
