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
      params = {:params => {'start_date'=> start_date, 'end_date'=> end_date, 'collapse'=> 'daily', 'api_key'=>api_keys.sample, 'Cache-Control' => 'max-age=0'}}
      request_url = url(stock_symbol)
      cache_key = request_url + '-' + start_date + '-' + end_date
      Rails.cache.fetch(cache_key, :expires =>12.hours) do
        response = RestClient.get(request_url,params)
        json = JSON.parse(response)
        data = json['dataset']['data']
      end
    end

    def check_data_set_available(stock_symbol, start_date, end_date)
      params = {:params => {'start_date'=> start_date, 'end_date'=> end_date, 'collapse'=> 'daily', 'api_key'=>api_keys.sample, 'Cache-Control' => 'max-age=0'}}
      request_url = url(stock_symbol)
      cache_key = request_url + '-' + start_date + '-' + end_date
      Rails.cache.fetch(cache_key, :expires =>12.hours) do
        begin
          response = RestClient.get(request_url,params)
          json = JSON.parse(response)
          data = json['dataset']['data']
        rescue RestClient::ExceptionWithResponse => err
          return false
        end
      end
      return true
    end


    private

    def source_api
      'YAHOO'
    end

    def api_keys
      ['wabv2ax3dxSBrdGUrT5L',
        'fnZMzzUYLE3DjK5Lf_S4'
      ]
    end

    def url(stock_symbol)
      url = "https://www.quandl.com/api/v3/datasets/#{source_api}/#{stock_symbol}.json"
    end

  end

end