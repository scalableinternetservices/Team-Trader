require 'rest-client'
require 'json'
require 'quandl_quote_service'

class QuotesController < ApplicationController

  def getHistoricalData
    # fresh_when(:params)
    returnArray = QuandlQuoteService.getHistoricalData params
    #returnArray = QuandlQuoteService.getData()
    @labels = returnArray[0]
    @values = returnArray[1]
    @stock_description = params[:ticker]
    
     return @labels, @values, @stock_description
  end

 
 end