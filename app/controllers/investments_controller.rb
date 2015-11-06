require 'quandl_quote_service'

class InvestmentsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @investments = Investment.where(user: current_user)
  end

  def getLivePrice(stock_symbol)
    
    start_date = "2015-11-04"
    end_date = "2015-11-05"
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
    @investment.overallGain = (livePrice - @investment.buyingPrice)*@investment.quantity
    @investment.totalValue =  livePrice*@investment.quantity
    @investment.totalInvestments =  @investment.buyingPrice*@investment.quantity
    @investment.overallGainPercent = (@investment.overallGain*100.00)/@investment.totalInvestments
    
  
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
  
end
