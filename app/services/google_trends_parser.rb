class GoogleTrendsParser
  
  def self.parse(data)
    self.new.parse(data)  
  end
  
  def parse(data)
    stripped = strip(data)
    
    hash = {}
    stripped.each_slice(2) do |slice|
      d = slice[0].sub('\u','')
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
   
end

