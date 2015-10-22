require 'rest-client'
require 'json'

class QuandlQuoteService
  class <<self
    
    def getHistoricalData(params)
      stock_symbol =params[:ticker]
      start_date = params[:start_date]
      end_date = params[:end_date]
      collapse = params[:collapse]
      
      params = {:params => {'start_date'=> start_date, 'end_date'=> end_date, 'collapse'=> collapse, 'api_key'=>api_key}}

      result = RestClient.get(url(stock_symbol),params)
      return JSON.parse(result)      
    end

    def getData(stock_symbol, start_date, end_date, collapse='weekly')
      params = {:params => {'start_date'=> start_date, 'end_date'=> end_date, 'collapse'=> collapse, 'api_key'=>api_key}}
      result = RestClient.get(url(stock_symbol),params)
      parse(result)
    end
    
    private
    
    def parse(data)
      result_json = JSON.parse(data)
      result_json = result_json['dataset']['data']

      dates = Array.new
      open = Array.new
      close = Array.new
      
      result_json.each do |val|
        dates.insert(0,val[0])
        open.insert(0,val[1])
        close.insert(0,val[3])
      end

      return dates, open, close
    end

    def source_api
      'YAHOO'
    end

    def api_key
      'wabv2ax3dxSBrdGUrT5L'
    end
    
    def url(stock_symbol)
      url = "https://www.quandl.com/api/v3/datasets/#{source_api}/#{stock_symbol}.json"
    end

  end

end