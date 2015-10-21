require 'quandl_quote_service'

class GoogleTrendsStrategyController < ApplicationController
  def index
  end

  def show

    returnArray = QuandlQuoteService.getHistoricalData params
    @labels = returnArray[0]
    @values = returnArray[1]
    @stock_description = returnArray[2]
    return @labels, @values, @stock_description
    # url = "https://www.quandl.com/api/v3/datasets/BCB/UDJIAD1.json?collapse=weekly&start_date=1896-07-14&end_date=2015-10-20"
    # params = {:params => {'start_date'=> start_date, 'end_date'=> end_date}}
    # fresh_when([params])
    # result = RestClient.get(url,params)
    # @result_json = JSON.parse(result)
    # @result_json = @result_json['dataset']['data']
    #
    # @labels = Array.new
    # @values = Array.new
    #
    # @result_json.each do |val|
    #   @labels.insert(0,val[0])
    #   @values.insert(0,val[1])
    # end
    # return @labels, @values
  end


end


  def PLChart
    # configure
    
    
  end