require 'quandl_quote_service'
class InvestmentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @investments = Investment.where(user: current_user)
    @investments
  end

  def getLivePrice(stock_symbol)
    start_date = Date.new(2015, 11, 04)
    end_date = Date.new(2015,11,05)
    @result_data = QuandlQuoteService.getDataArray(stock_symbol, start_date, end_date)

    @values = Array.new
    @result_data.each do |val|
      @values.insert(0,val[4])
    end
    puts @values
    return @values[0]

  end

  def create
    params = investment_params
    live_price =  getLivePrice(params.fetch(:ticker))
    params.new(buyingPrice:live_price)
    @investment = current_user.investments.new(investment_params)

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
   a = params.require(:investment).permit(:stockName,:ticker,:quantity)
    a
  end

end
