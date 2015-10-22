require 'quandl_quote_service'
require 'google_trends_service'

class GoogleTrendsStrategyController < ApplicationController
  def index
  end

  def show
    today = Date.today
    beginning = today-1095#124#1095
    start_date = beginning.to_s#'2015-07-03'
    end_date = today.to_s#'2015-09-30'

    trend_data = GoogleTrendsService.getMonths(params[:trend_term], 12)

    @labels = trend_data.keys
    @values = trend_data.values
    rel_search = get_array_of_relative_search @values

    returnArray = QuandlQuoteService.getData(params[:stock_symbol], start_date, end_date, 'daily')
    @dates = returnArray[0]
    @open = returnArray[1]
    @close = returnArray[2]

    logger.info @close
    @values2 = @close

    @bh_ret = Array.new(@labels.size,1)
    @gt_ret = Array.new(@labels.size,1)

    cum_ret = 1
    @labels.each_with_index do |val,index|
      if((index > delta_t) && index!=@labels.size-1)
        @bh_ret[index] = cum_ret = cum_ret + week_return(val)
      end
    end

    cum_ret = 1
    @labels.each_with_index do |val,index|
      if((index > delta_t) && index!=@labels.size-1)
        if(rel_search[index-1] > 0)
          @gt_ret[index] = cum_ret = cum_ret + week_return(val)
        else
          @gt_ret[index] = cum_ret = cum_ret - week_return(val)
        end
      
      end
    end

    #@gt_ret.reverse!
    @labels = @labels.drop(delta_t)
    @bh_ret = @bh_ret.drop(delta_t)
    @gt_ret = @gt_ret.drop(delta_t)
    
    @labels = @labels.reverse.drop(1).reverse
    @bh_ret = @bh_ret.reverse.drop(1).reverse
    @gt_ret = @gt_ret.reverse.drop(1).reverse

  end

  private

  def delta_t
    2
  end

  def week_return(saturday)
    f = close_first_day(saturday)
    e = close_next_week(saturday)
    returns(f,e)
  end

  def first_trade_day(saturday)
    d = Date.parse saturday
    d=d+2
    while(@dates.index(d.to_s) == nil)
      d=d+1
    end
    d
  end

  def first_trade_day_next_week(saturday)
    d = Date.parse saturday
    d=d+9
    while(@dates.index(d.to_s) == nil)
      d=d+1
    end
    d
  end

  def close_first_day(saturday)
    d = first_trade_day(saturday)
    getClose(d)
  end

  def close_next_week(saturday)
    d = first_trade_day_next_week(saturday)
    getClose(d)
  end

  def returns(st,en)
    Math.log(en) - Math.log(st)
  end

  def getClose(date)
    i = @dates.index(date.to_s)
    @close[i]
  end

  def get_array_of_relative_search(values)
    rel = Array.new(values.size,0)

    values.each_with_index do |val, index|
      if((index >= delta_t) && index!=values.size-1)
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
