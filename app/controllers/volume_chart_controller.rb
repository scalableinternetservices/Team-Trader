class VolumeChartController < ApplicationController
  require 'rest-client'
  require 'json'

  def get_search_history
    @term_records = TermSearchHistory.all.order('count DESC')
    @stock_records = StockSearchHistory.all.order('count DESC')

    return @stock_records, @term_records
  end

  def index

    return get_search_history()

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

  	# configure
    params[:start_date] = "2014-6-20"
    params[:end_date] = "2014-9-20"
    # puts params
    @result_json = QuandlQuoteService.getHistoricalData(params)
    @result_json = @result_json['dataset']['data']
    # puts @result_json

    # @trends = GoogleTrendsService.getDaily("debt")

    @labels = Array.new
    @values = Array.new
    @trend_labels = Array.new
    @trend_values = Array.new

    @result_json.each do |val|
      @labels.insert(0,val[0])
      @values.insert(0,val[5])
    end

    # @trends.each do |key, value|
    #   if @trend_values.length < @values.length
    #     @trend_values.insert(0, value)
    #   end
    # end

    return @labels, @values, @trend_values
  end
end
# 