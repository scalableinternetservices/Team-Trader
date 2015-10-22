class VolumeChartController < ApplicationController
  require 'rest-client'
  require 'json'
  require 'google_trends_service'
  def index
  	# configure
    
	  start_date = params[:start_date]
    end_date = params[:end_date]
    url = "https://www.quandl.com/api/v3/datasets/YAHOO/INDEX_DJI.json"
    params = {:params => {'start_date'=> start_date, 'end_date'=> end_date}}
    fresh_when([params])
    result = RestClient.get(url,params)
    @result_json = JSON.parse(result)
    @result_json = @result_json['dataset']['data']

    # @trends = GoogleTrendsService.getDaily("debt")

    @labels = Array.new
    @values = Array.new
    @trend_labels = Array.new
    @trend_values = Array.new

    @result_json.each do |val|
      @labels.insert(0,val[0])
      @values.insert(0,val[5])
    end

    # @trends.each do |key, value|
    #   if @trend_values.length < @values.length
    #     @trend_values.insert(0, value)
    #   end
    # end

    return @labels, @values, @trend_values
  end
end
