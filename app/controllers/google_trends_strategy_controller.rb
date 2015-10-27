
class GoogleTrendsStrategyController < ApplicationController
  def index
  end

  def updateSearchHistory
    stock_symbol = params[:stock_symbol].downcase
    trend_term = params[:trend_term].downcase

    if StockSearchHistory.where(stock: stock_symbol).empty?
      StockSearchHistory.create(stock: stock_symbol, count:1)
    else
      query_stock = StockSearchHistory.where(:stock => stock_symbol).first
      query_stock.increment!(:count)
      query_stock.save
    end

    if TermSearchHistory.where(term: trend_term).empty?
      TermSearchHistory.create(term: trend_term, count:1)
    else
      query_term = TermSearchHistory.where(:term => trend_term).first
      query_term.increment!(:count)
      query_term.save
    end
  end

  def show

    updateSearchHistory()

    today = Date.today
    beginning = today-1095#124#1095
    start_date = beginning.to_s#'2015-07-03'
    end_date = today.to_s#'2015-09-30'

    trend_data = GoogleTrendsService.getMonths(params[:trend_term], 12)

    @labels = trend_data.keys
    @values = trend_data.values
    rel_search = get_array_of_relative_search @values

    @date_close_hash = QuandlQuoteService.getDateCloseHash(params[:stock_symbol], start_date, end_date)

    @bh_ret = Array.new(@labels.size,1)
    @gt_ret = Array.new(@labels.size,1)

    bh_cum_ret = 1
    gt_cum_ret = 1
    @labels.each_with_index do |val,index|
      if((index > delta_t) && index!=@labels.size-1)
        ret = week_return_hash(val)
        @bh_ret[index] = bh_cum_ret += ret
        if(rel_search[index-1] > 0)
          @gt_ret[index] = gt_cum_ret += ret
        else
          @gt_ret[index] = gt_cum_ret -= ret
        end
      
      end
    end
    
    @labels = @labels.drop(delta_t)
    @bh_ret = @bh_ret.drop(delta_t)
    @gt_ret = @gt_ret.drop(delta_t)
    
    @labels = @labels.reverse.drop(1).reverse
    @bh_ret = @bh_ret.reverse.drop(1).reverse
    @gt_ret = @gt_ret.reverse.drop(1).reverse
    
  end

  private

  def delta_t
    3
  end
  
  def week_return_hash(saturday)
    this_week = first_trade_day_this_week(saturday)
    next_week = first_trade_day_next_week(saturday)
    f = @date_close_hash[this_week.to_s]
    e = @date_close_hash[next_week.to_s]
    returns(f,e)
  end
  
  def first_trade_day_this_week(saturday)
    d = Date.parse saturday
    d=d+2
    next_trade_day_hash(d)
  end
  
  def first_trade_day_next_week(saturday)
    d = Date.parse saturday
    d=d+9
    next_trade_day_hash(d)
  end
  
  def next_trade_day_hash(day)#takes in Date
    while(@date_close_hash[day.to_s] == nil)
      day +=1
    end
    day
  end
  
  def returns(st,en)
    Math.log(en) - Math.log(st)
  end

  def get_array_of_relative_search(values)
    rel = Array.new(values.size,0)

    values.each_with_index do |val, index|
      if((index >= delta_t) && index!=values.size-1)
        rel[index] = relative_change_in_search(index, values)
      end
    end
    rel
  end

  def relative_change_in_search(index, values)
    m = values[index-delta_t,index-1].mean
    values[index] - m
  end

end
