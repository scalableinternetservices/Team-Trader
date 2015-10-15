require 'rest-client'

class QuotesController < ApplicationController
  
  def getHistoricalData()
    stock_ticker ="YHOO"
    end_date = "2015-02-18"
    start_date ="2014-02-11"
    response = RestClient.get 'https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.historicaldata%20where%20symbol%20%3D%20%22'+stock_ticker+'%22%20and%20startDate%20%3D%20%22'+start_date+'%22%20and%20endDate%20%3D%20%22'+end_date+'%22&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback='
    @output = response.body
  end
end
