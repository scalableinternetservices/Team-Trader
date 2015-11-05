class InvestmentsController < ApplicationController
  def index
    @investments = Investment.where(id: params[:portfolio_id])
    @portfolio = Portfolio.find_by_id(params[:portfolio_id])
  end

  def mock_index

  end
end
