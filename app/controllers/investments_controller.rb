require 'quandl_quote_service'

class InvestmentsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @investments = Investment.where(user: current_user)
  end

  def getLivePrice(stock_symbol)
    
    start_date = yesterday
    end_date = current_date
    
    @result_data = QuandlQuoteService.getDataArray(stock_symbol, start_date, end_date)

    @values = Array.new
    @result_data.each do |val|
      @values.insert(0,val[4])
    end
    puts @values
    return @values[0]

  end

  def create

    @investment = current_user.investments.new(investment_params)
    
    livePrice = getLivePrice(investment_params[:ticker])
    @investment.livePrice= livePrice
    @investment.buyingPrice = livePrice
    @investment.buyingDate = current_date
    @investment.overallGain = (livePrice - @investment.buyingPrice)*@investment.quantity
    @investment.totalValue =  livePrice*@investment.quantity
    @investment.totalInvestments =  @investment.buyingPrice*@investment.quantity
    @investment.overallGainPercent = (@investment.overallGain*hundred)/@investment.totalInvestments
    
  
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
    params.require(:investment).permit(:stockName,:ticker,:quantity)
  end
  
  def current_date
    time = Time.new
    return time.strftime("%Y-%m-%d")
  end
  
  def yesterday
    time = Time.now - 1.day
    return time.strftime("%Y-%m-%d")
  end
  
  def hundred
    100.00
  end
    
end
