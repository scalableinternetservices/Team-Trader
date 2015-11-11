class RandomGtQueryController < ApplicationController
  def volume

	offset = rand(TermSearchHistory.count)
	t = TermSearchHistory.offset(offset).first
  	puts t.term
  	redirect_to controller: 'volume_chart', action: 'show', stock_symbol: 'Apple Inc.(AAPL)', trend_term: t.term

  end

  def gts
  	offset = rand(TermSearchHistory.count)
	t = TermSearchHistory.offset(offset).first
  	puts t.term
  	redirect_to controller: 'google_trends_strategy', action: 'show', stock_symbol: 'Apple Inc.(AAPL)', trend_term: t.term

  end
end
