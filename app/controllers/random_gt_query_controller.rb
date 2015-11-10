class RandomGtQueryController < ApplicationController
  def volume

  	t = TermSearchHistory.order("RANDOM()").first
  	puts t.term
  	redirect_to controller: 'volume_chart', action: 'show', stock_symbol: 'aapl', trend_term: t.term

  end

  def gts

  	t = TermSearchHistory.order("RANDOM()").first
  	puts t.term
  	redirect_to controller: 'google_trends_strategy', action: 'show', stock_symbol: 'aapl', trend_term: t.term

  end
end
