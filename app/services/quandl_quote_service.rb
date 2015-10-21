class QuandlQuoteService

  def self.getHistoricalData(params)

    source_api = 'YAHOO'
    stock_ticker =params[:ticker]
    start_date = params[:start_date]
    end_date = params[:end_date]
    collapse = params[:collapse]
    url = "https://www.quandl.com/api/v3/datasets/#{source_api}/#{stock_ticker}.json"
    params = {:params => {'ticker'=> stock_ticker, 'start_date'=> start_date, 'end_date'=> end_date, 'collapse'=> collapse}}

    result = RestClient.get(url,params)
    @result_json = JSON.parse(result)
    @result_json = @result_json['dataset']['data']

    @labels = Array.new
    @values = Array.new

    @result_json.each do |val|
      @labels.insert(0,val[0])
      @values.insert(0,val[1])
    end

    @stock_description = stock_ticker
    @start = start_date
    @end = end_date

    return @labels, @values, @stock_description
  end
end