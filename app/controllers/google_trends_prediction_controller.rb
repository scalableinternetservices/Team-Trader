class GoogleTrendsPredictionController < ApplicationController
  def index
  end

  def show
    @trend_term = params[:trend_term]
    trend_data = GoogleTrendsService.getMonths(params[:trend_term], 12)
    @hash = trend_data
    @labels = trend_data.keys
    @values = trend_data.values
    
    @ret_string = 'decreasing'
    val = @values[-1] - (@values[-2]+@values[-3]+@values[-4])/3.0
    #@ret_string = values
    if(val < 0)
      @ret_string = 'decreasing'
    else
      @ret_string = 'increasing'
    end
  end
  
  private
  
  def delta_t
    3
  end
end
