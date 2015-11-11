class VolumeChartController < ApplicationController
  require 'rest-client'
  require 'json'

  def get_search_history
    @term_records = TermSearchHistory.all.order('count DESC').limit(8)
    @stock_records = StockSearchHistory.all.order('count DESC').limit(8)

    return @stock_records, @term_records
  end

  def index
    get_search_history()
  end

  def update_search_history
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

    update_search_history()


    today = Date.today
    beginning = today-400#124#1095
    start_date = beginning.to_s#'2015-07-03'
    end_date = today.to_s#'2015-09-30'
    params[:start_date] = start_date
    params[:end_date] = end_date

    @date_close_hash = QuandlQuoteService.getHistoricalVolume(params)

    @trend_data = GoogleTrendsService.getMonths(params[:trend_term], 12)

    @trend_labels = @trend_data.keys
    @trend_values = @trend_data.values
    

    @volume_values = Array.new

    @trend_labels.each_with_index do |val,index|
      if((index > delta_t) && index<@trend_labels.size)
        @volume_values.insert(0,week_return_hash(val))
        # puts ret
      end
    end

    @trend_labels = @trend_labels.drop(delta_t)

    puts @volume_values
    puts @trend_data


    return @trend_labels, @trend_values, @volume_values
  end


  def delta_t
    3
  end

  def week_return_hash(saturday)
    this_week = first_trade_day_this_week(saturday)
    # next_week = first_trade_day_next_week(saturday)
    f = @date_close_hash[this_week.to_s]
    return f
    # e = @date_close_hash[next_week.to_s]
    # returns(f,e)
  end
  
  def first_trade_day_this_week(saturday)
    d = Date.parse saturday
    d=d+2
    next_trade_day_hash(d)
  end

  def next_trade_day_hash(day)#takes in Date
    while(@date_close_hash[day.to_s] == nil)
      day +=1
    end
    day
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
# 