class VolumeChartController < ApplicationController
  require 'rest-client'
  require 'json'

  def index
  end
  
  def show

    stock_symbol = params[:ticker]

    if StockSearchHistory.where(stock: stock_symbol).empty?
      StockSearchHistory.create(stock: stock_symbol, count:1)
    else
      s = StockSearchHistory.where(:stock => stock_symbol).first
      s.increment!(:count)
      s.save

    end

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