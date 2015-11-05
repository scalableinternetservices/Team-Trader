class PortfoliosController < ApplicationController
  before_action :authenticate_user!

  def index
    user = current_user
    @portfolios = Portfolio.where(user: current_user)
    # @portfolios = Portfolio.all
    # @portfolios
  end

end
