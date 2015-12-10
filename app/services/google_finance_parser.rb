class GoogleFinanceParser
  
  def self.parse(data)
    self.new.parse(data)  
  end
  
  def parse(data)
    # data.each_line do |line|
      # puts line
    # end
    
    date_to_price = {}
    lines = data.split(/\r?\n/)[7,data.size]
    lines.each do |line|
      d = line.split(',')
      if d[0][0] == 'a'
        @current_date = Integer(d[0][1..-1])
        date_to_price[@current_date] = Float(d[1])
      else
        date = @current_date + 60*Integer(d[0])
        date_to_price[date] = Float(d[1])
      end
    end
    date_to_price
  end
    
end

