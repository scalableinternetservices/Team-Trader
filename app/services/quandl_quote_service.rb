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
      parse(result)      
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

      labels = Array.new
      values = Array.new

      result_json.each do |val|
        labels.insert(0,val[0])
        values.insert(0,val[1])
      end

      return labels, values
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