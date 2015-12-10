class GoogleTrendsService
  class <<self
    
    def get(symbol, exchange, interval)
    end
    
    private
    
    def url
      'http://www.google.com/finance/getprices'
    end
    
    def common_params
      '?f=d,o,h,l,c,v&x=NASD&i=60&p=1d'
    end
    
    def create_request(term)
      action_url + common_params + '&q=' + term
    end
    
  end
end

#TODO find max ranges for intervals
#TODO get  https://www.google.com/finance?q=GOOGLEINDEX_US%3AINVEST&ei=CgZoVoHhM8_-mAHouLygAw

# The base url is 
# q is the symbol (AAPL)
# x is the exchange (NASD)
# i is the interval in seconds (120 = seconds = 2 minutes)
# sessions is the session requested (ext_hours)
# p is the time period (5d = 5 days)
# f is the requested fields (d,c,v,o,h,l)  DATE,CLOSE,HIGH,LOW,OPEN,VOLUME
# df ?? (cpct)
# auto ?? (1)
# ts is potentially a time stamp (1324323553 905)

#http://trading.cheno.net/downloading-google-intraday-historical-data-with-python/
#http://www.google.com/finance/getprices?q=AAPL&i=60&p=10h&f=d,o,h,l,c,v
#http://finance.google.com/finance/info?client=ig&q=AAPL

#https://www.google.com/finance/getprices?q=INVEST&x=GOOGLEINDEX_US&i=86400&p=1Y&f=d,c,v,o,h,l&df=cpct&auto=1&ts=1449661513544&ei=aRNoVrnYFInlmAH57I2wDw



#http://stackoverflow.com/questions/25338608/download-all-stock-symbol-list-of-a-market
#http://www.nasdaq.com/screening/companies-by-industry.aspx?exchange=NYSE&render=download
#https://www.google.com/trends/hottrends/visualize?ss=&pn=p&nrow=5&ncol=5
#http://www.theodor.io/scraping-google-finance-data-using-pandas/

#https://jqueryui.com/autocomplete/