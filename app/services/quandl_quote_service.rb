class QuandlQuoteService
  class <<self
    
    #Used for fetching prices of stocks
    def getHistoricalData(params)
      stock_symbol =params[:stock_symbol]
      start_date = params[:start_date]
      end_date = params[:end_date]
      collapse = params[:collapse]
      
      puts "Inside the Historical Data Section"
      puts params
      data = getDataArray(stock_symbol, start_date, end_date)
      return data;
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

    #rao_sharath will Delete this method after Thursday Lab on 10/29
    def fetchHistoricalData(params)
      stock_symbol =params[:ticker]
      start_date = params[:start_date]
      end_date = params[:end_date]
      collapse = params[:collapse]

      stocks_by_ticker = QuoteCachingService.fetch_for_date_range(stock_symbol, start_date, end_date)
      if(stocks_by_ticker !=nil && !stocks_by_ticker.empty?)
        parseFromDatabase(stocks_by_ticker)
      else
        result = getHistoricalDataFromExternalApis(stock_symbol, collapse)
        parse(result, start_date, end_date)
      end

    end

    #rao_sharath will Delete this method after Thursday Lab on 10/29
    def getHistoricalDataFromExternalApis(stock_symbol, collapse)

      params = {:params => {'start_date'=> max_start_date, 'end_date'=> current_date, 'collapse'=> collapse, 'api_key'=>api_key}}
      result = RestClient.get(url(stock_symbol),params)
      QuoteCachingService.save(result)

      return result
    end

    private

    #rao_sharath will Delete this method after Thursday Lab on 10/29
    def parseFromDatabase(data)

      labels = Array.new
      values = Array.new

      data.each do |val|
        labels.insert(0,val.date)
        values.insert(0,val.open_price)
      end

      return labels, values
    end

    #rao_sharath will Delete this method after Thursday Lab on 10/29
    def parse(data, start_date, end_date)
      result_json = JSON.parse(data)
      result_json = result_json['dataset']['data']

      labels = Array.new
      values = Array.new

      result_json.each do |val|
        if(val[0].to_date >= start_date.to_date && val[0].to_date <= end_date.to_date)
        labels.insert(0,val[0])
        values.insert(0,val[1])
        end

      end

      return labels, values
    end

    def current_date
      '2015-10-25'
    end

    def max_start_date
      '2012-11-30'
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