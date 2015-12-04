
class GoogleTrendsStrategyController < ApplicationController
  before_action :validateAndExtractInput, only: :show

  def get_search_history(limit = 8)
    @term_records = TermSearchHistory.order('count DESC').limit(limit)
    @stock_records = StockSearchHistory.order('count DESC').limit(limit)

  end

  def get_stock_search_history(limit = 8)
    @stock_records = StockSearchHistory.all.order('count DESC').limit(limit)
    respond_to do |format|
      format.json { render json: @stock_records}
    end
  end

  def get_term_search_history(limit = 8)
    @term_records = TermSearchHistory.all.order('count DESC').limit(limit)
    respond_to do |format|
      format.json { render json: @term_records}
    end
  end

  def index
    get_search_history()
  end

  def update_search_history
    stock_symbol = params[:stock_symbol]
    trend_term = params[:trend_term].downcase

    stockSearchRelation = StockSearchHistory.where(stock: stock_symbol)
    termSearchRelation = TermSearchHistory.where(term: trend_term)

    if stockSearchRelation.empty?
      StockSearchHistory.create(stock: stock_symbol, count:1)
    else
      query_stock = stockSearchRelation.first
      query_stock.increment!(:count)
    end

    if termSearchRelation.empty?
      TermSearchHistory.create(term: trend_term, count:1)
    else
      query_term = termSearchRelation.first
      query_term.increment!(:count)
    end
  end

  def show
    today = Date.today
    beginning = today-400#124#1095
    start_date = beginning.to_s#'2015-07-03'
    end_date = today.to_s#'2015-09-30'

    update_search_history()

    if(!QuandlQuoteService.check_data_set_available(params[:stock_symbol], start_date, end_date))
      redirect_to google_trends_strategy_index_url , :notice=>'Sorry, the stock you search is currently unavailable in database'
      return
    end

    trend_data = GoogleTrendsService.getMonths(params[:trend_term], 12)

    @labels = trend_data.keys
    @values = trend_data.values
    rel_search = get_array_of_relative_search @values

    @date_close_hash = QuandlQuoteService.getDateCloseHash(params[:stock_symbol], start_date, end_date)

    @bh_ret = Array.new(@labels.size,1)
    @gt_ret = Array.new(@labels.size,1)

    bh_cum_ret = 1
    gt_cum_ret = 1
    @labels.each_with_index do |val,index|
      if((index > delta_t) && index!=@labels.size-1)
        ret = week_return_hash(val)
        @bh_ret[index] = bh_cum_ret += ret
        if(rel_search[index-1] > 0)
          @gt_ret[index] = gt_cum_ret += ret
        else
          @gt_ret[index] = gt_cum_ret -= ret
        end
      
      end
    end
    
    @ret_string = 'decreasing'
    val = @values[-1] - (@values[-2]+@values[-3]+@values[-4])/3.0
    if(val < 0)
      @ret_string = 'decreasing'
    else
      @ret_string = 'increasing'
    end
    
    @labels = @labels.drop(delta_t)
    @bh_ret = @bh_ret.drop(delta_t)
    @gt_ret = @gt_ret.drop(delta_t)
    
    @labels.pop
    @bh_ret.pop
    @gt_ret.pop

    @stock_info = Index.find_by(symbol:params[:stock_symbol])
    @trend_term = params[:trend_term]

  end

  private

  def delta_t
    3.0
  end
  
  def week_return_hash(saturday)
    this_week = first_trade_day_this_week(saturday)
    next_week = first_trade_day_next_week(saturday)
    f = @date_close_hash[this_week.to_s]
    e = @date_close_hash[next_week.to_s]
    returns(f,e)
  end
  
  def first_trade_day_this_week(saturday)
    d = Date.parse saturday
    d=d+2
    next_trade_day_hash(d)
  end
  
  def first_trade_day_next_week(saturday)
    d = Date.parse saturday
    d=d+9
    next_trade_day_hash(d)
  end
  
  def next_trade_day_hash(day)#takes in Date
    while(@date_close_hash[day.to_s] == nil)
      day +=1
    end
    day
  end
  
  def returns(st,en)
    Math.log(en) - Math.log(st)
  end

  def get_array_of_relative_search(values)
    rel = Array.new(values.size,0)

    values.each_with_index do |val, index|
      if((index >= delta_t) && index!=values.size-1)
        rel[index] = relative_change_in_search(index, values)
      end
    end
    rel
  end

  def relative_change_in_search(index, values)
    m = values[index-delta_t,index-1].mean
    values[index] - m
  end

  private
  def validateAndExtractInput
    if (params[:stock_symbol].nil? || params[:stock_symbol] == '')
      redirect_to google_trends_strategy_index_url, :notice=>'Stock symbol is empty'
      return
    end

    if (params[:stock_symbol].nil? || params[:stock_symbol] == '')
      redirect_to google_trends_strategy_index_url, :notice=>'Trend is empty'
      return
    end

    if ((/.*\((.*)\)/ =~ params[:stock_symbol]).nil?)
      redirect_to google_trends_strategy_index_url, :notice=>'Stock symbol illegal. Format: Name(Symbol)'
      return
    end

    #Extract Input
    params[:stock_symbol] = /.*\((.*)\)/.match(params[:stock_symbol])[1]
  end

end
