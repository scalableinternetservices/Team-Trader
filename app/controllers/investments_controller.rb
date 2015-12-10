require 'quandl_quote_service'

class InvestmentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @investments = Investment.where(user: current_user)
    @total = 0.0
    @profit =0.0

    if @investments != nil
      @investments.each do |investment|
        @total = @total + investment.totalValue
        @profit = @profit +investment.overallGain
      end
    end

    @total.round(2)
    @profit.round(2)

  end

  def getLivePrice(stock_symbol)

    Integer i =0;

    while true do
      start_date = date(i+1)
      end_date = date(i)

      @result_data = QuandlQuoteService.getDataArray(stock_symbol, start_date, end_date)
      @values = Array.new

      @result_data.each do |val|
        @values.insert(0,val[4])
      end

      if @values[0] !=nil
      return @values[0]
      end

      i = i+1;

      if i>2
      return 0.0;
      end
    end
  end


  def getBeforePrice(stock_symbol)

    Integer i =0;

    while true do
      start_date = date(i+30)
      end_date = date(i+29)

      @result_data = QuandlQuoteService.getDataArray(stock_symbol, start_date, end_date)
      @values = Array.new

      @result_data.each do |val|
        @values.insert(0,val[4])
      end

      if @values[0] !=nil
        return @values[0]
      end

      i = i+1;

      if i>2
        return 0.0;
      end
    end
  end

  def create
    @investment = current_user.investments.new()
    @investment.ticker = extractTicker(params[:stockName])
    @investment.stockName = extractStockName(params[:stockName])
    @investment.quantity = params[:quantity]
    livePrice = getLivePrice(@investment.ticker).round(2)
    @investment.livePrice= livePrice
    @investment.buyingPrice =  getBeforePrice(@investment.ticker).round(2)
    @investment.buyingDate = date(2)
    @investment.overallGain = ((livePrice - @investment.buyingPrice)*@investment.quantity).round(2)
    @investment.totalValue =  (livePrice*@investment.quantity).round(2)
    @investment.totalInvestments =  (@investment.buyingPrice*@investment.quantity).round(2)
    @investment.overallGainPercent = 0.0
    if @investment.totalInvestments != 0.0
      @investment.overallGainPercent = ((@investment.overallGain*hundred)/@investment.totalInvestments).round(2)
    end

    respond_to do |format|
      if @investment.save
        format.html { redirect_to investments_path, notice: 'Investment was successfully created.' }
        format.json { render :show, status: :created, location: @investment }
      else
        format.html { render :new }
        format.json { render json: @investment.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @investment = Investment.new
  end

  def mock_index

  end

  private

  def investment_params
    params.require(:investment).permit(:stockName,:quantity)
  end

  def current_date
    time = Time.new
    return time.strftime("%Y-%m-%d")
  end

  def date (offset_days)
    time = Time.now

    if(offset_days > 0 )
    time = time - offset_days.day
    end

    return time.strftime("%Y-%m-%d")
  end

  def hundred
    100.00
  end

  def extractTicker(stock)
    /.*\((.*)\)/.match(stock)[1]
  end

  def extractStockName(stock)
    /(.*)\(.*\)/.match(stock)[1]
  end

end
