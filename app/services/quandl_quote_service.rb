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

    def getDateCloseHash(stock_symbol, start_date, end_date)
      data = getDataArray(stock_symbol, start_date, end_date)
      
      hash = {}
      data.each do |val|
        hash[val[0]] = val[4]
      end       
      hash
    end
    
    private
    
    def getDataArray(stock_symbol, start_date, end_date)
      params = {:params => {'start_date'=> start_date, 'end_date'=> end_date, 'collapse'=> 'daily', 'api_key'=>api_key}}
      result = RestClient.get(url(stock_symbol),params)
      puts result
      json = JSON.parse(result)
      data = json['dataset']['data']
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