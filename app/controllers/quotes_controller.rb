require 'rest-client'
require 'json'

class QuotesController < ApplicationController
  
  def getHistoricalData
   
      source_api = 'YAHOO'
      stock_ticker =params[:ticker]
      start_date = params[:start_date]
      end_date = params[:end_date]
      
      url = "https://www.quandl.com/api/v3/datasets/#{source_api}/#{stock_ticker}.json"
          
      params = {:params => {'ticker'=> stock_ticker, 'start_date'=> start_date, 'end_date'=> end_date}}
      fresh_when([params])
      result = RestClient.get(url,params)
      @result_json = JSON.parse(result)
      @result_json = @result_json['dataset']['data']
  
      @labels = Array.new
      @values = Array.new
  
      @result_json.each do |val|
        @labels.insert(0,val[0])
        @values.insert(0,val[1])
      end
  
      return @labels, @values
    end