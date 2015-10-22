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
  end
end