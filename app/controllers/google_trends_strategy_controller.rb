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

    trend_data = GoogleTrendsService.getMonths(params[:trend_term], 4)

    @labels = trend_data.keys
    @values = trend_data.values
    @values2 = trend_data.values
    @values2 = get_array_of_relative_search @values

  #@labels.reverse!
  #@values.reverse!

  #returnArray = QuandlQuoteService.getData(params[:stock_symbol], start_date, end_date, 'daily')
  #@labels = returnArray[0]
  #@values = returnArray[1]
  end

  private

  def delta_t
    3
  end

  def get_array_of_relative_search(values)
    rel = Array.new(values.size,0)

    values.each_with_index do |val, index|
      if((index > 2) && index!=values.size-1)
        rel[index] = relative_change_in_search(index, values)
        
      end
    end
    logger.info rel
    logger.info @values
    rel
  end

  def relative_change_in_search(index, values)
    m = values[index-delta_t,index-1].mean
    values[index] - m
  end

end