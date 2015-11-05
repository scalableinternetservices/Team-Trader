class QuandlQuoteService
  class <<self
    
    #Used for fetching prices of stocks
    def getHistoricalData(params)
      stock_symbol =params[:stock_symbol]
      start_date = params[:start_date]
      end_date = params[:end_date]
      collapse = params[:collapse]
      
      data = getDataArray(stock_symbol, start_date, end_date)
    end

    #Used for fetching prices of stocks
    def getHistoricalVolume(params)
      stock_symbol =params[:stock_symbol]
      start_date = params[:start_date]
      end_date = params[:end_date]
      collapse = params[:collapse]
      
      data = getDataArray(stock_symbol, start_date, end_date)

      hash = {}
      data.each do |val|
        hash[val[0]] = val[5]
      end
      return hash;
    end

    #Used for fetching prices of stocks
    def getDateCloseHash(stock_symbol, start_date, end_date)
      data = getDataArray(stock_symbol, start_date, end_date)

      hash = {}
      data.each do |val|
        hash[val[0]] = val[4]
      end
      hash
    end
    
    def getDataArray(stock_symbol, start_date, end_date)
      params = {:params => {'start_date'=> start_date, 'end_date'=> end_date, 'collapse'=> 'daily', 'api_key'=>api_key, 'Cache-Control' => 'max-age=0'}}

      request_url = url(stock_symbol)

      Rails.cache.fetch(request_url, :expires =>12.hours) do
        response = RestClient.get(request_url,params)
        json = JSON.parse(response)
        data = json['dataset']['data']
      end
    end

    private

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