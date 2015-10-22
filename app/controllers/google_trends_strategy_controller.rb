require 'quandl_quote_service'
require 'google_trends_service'

class GoogleTrendsStrategyController < ApplicationController
  def index
  end

  def show
    today = Date.today
    beginning = today-365#1095
    start_date = beginning.to_s#'2015-07-03'
    end_date = today.to_s#'2015-09-30'
 
    returnArray = QuandlQuoteService.getData(params[:stock_symbol], start_date, end_date)
    @labels = returnArray[0]
    @values = returnArray[1]
  end

end