class GoogleTrendsParser
  
  def self.parse(data)
    self.new.parse(data)  
  end
  
  def parse(data)
    stripped = strip(data)
    
    hash = {}
    stripped.each_slice(2) do |slice|
      d = slice[0]
      d = d[comma_date_regex]
      if(d==nil)
        d = slice[0].sub(remove_dash_regex,'')
      end
      
      d = Date.parse d
      begin 
        hash[d.to_s] = Integer(slice[1])
      rescue ArgumentError, TypeError
        next
      end
    end
    hash
    
  end
    
  private
 
  def strip(data)
    regex = /"f":"(.*?)"}/
    data.scan(regex).flatten
  end
  
  def comma_date_regex
    /[A-Z][a-z]{2}\s(\d{1,2}),\s\d{4}\s\\u2013/
  end
  
  def remove_dash_regex
    /\\u2013(\s[A-Z][a-z]{2})?\s(\d{1,2}),\s/
  end
   
end

