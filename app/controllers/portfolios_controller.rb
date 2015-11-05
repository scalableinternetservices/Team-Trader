class PortfoliosController < ApplicationController
  # => before_action :authenticate_user!

  def index
    #user = current_user
    #@portfolios = Portfolio.where(user: current_user)
    # @portfolios = Portfolio.all
    # @portfolios
  end

  def show
    @portfolios = Portfolio.where(user_id: 1)
    return @portfolios
  end
end
