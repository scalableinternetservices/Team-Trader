class QuoteCachingService
  class <<self
   
   def save(data)
      result_json = JSON.parse(data)
      json = result_json['dataset']['data']
      ticker = result_json['dataset']['dataset_code']

      json.each do |val|
        s = Stock.new
        s.ticker = ticker
        s.date =val[0]
        s.price = val[1]
        s.save
      end
    end
    
    
    def fetch_for_date_range(ticker_name,start_date, end_date)
      
     stocks_by_ticker = fetch(ticker_name)
     stocks_by_date_range = Array.new
      
      stocks_by_ticker.each do |stock|
        if(stock.date.to_date >= start_date.to_date && stock.date.to_date <= end_date.to_date)
          stocks_by_date_range.insert(0, stock)
        end
      end
      
      return stocks_by_date_range
    end
    
    def fetch(ticker_name)
       stocks_by_ticker = Array.new
       all_stocks = Stock.all
      
      all_stocks.each do |stock|
        if(stock.ticker == ticker_name)
          stocks_by_ticker.insert(0, stock)
        end
      end
      
      return stocks_by_ticker
    end
      
    
    
  end
end