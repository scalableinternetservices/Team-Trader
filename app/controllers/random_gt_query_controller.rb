class RandomGtQueryController < ApplicationController
  def volume
  	redirect_to controller: 'volume_chart', action: 'show', stock_symbol: rand_stock, trend_term: rand_term
  end

  def gts
  	redirect_to controller: 'google_trends_strategy', action: 'show', stock_symbol: rand_stock, trend_term: rand_term
  end
  
  def rand_term
    terms.sample
  end
  
  def rand_stock
    stocks.sample
  end
  
  def terms
    ['southwest', 'expectations', 'independence', 'knowing', 'debt', 'stock', 'portfolio', 'investment', 'hedge', 'economics', 'markets', 'bond', 'kangaroo', 'navigator', 'tablespoon']
  end
  
  def stocks
    ['Apple Inc.(AAPL)', 'Alphabet Inc.(GOOG)', 'Microsoft Corporation(MSFT)', 'Yahoo! Inc.(YHOO)', 
      'Alphabet Inc.(GOOGL)', 'Big 5 Sporting Goods Corporation(BGFV)', 'Bank of America Corporation(BAC)', 
      'Intel Corporation(INTC)', 'Chase Corporation(CCF)']
  end
end
