class VolumeChartController < ApplicationController
  require 'rest-client'
  require 'json'
  require 'google_trends_service'
  require 'quandl_quote_service'

  def index
  	# configure

    @result_json = QuandlQuoteService.getHistoricalData(params)
    @result_json = @result_json['dataset']['data']
    puts @result_json

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
