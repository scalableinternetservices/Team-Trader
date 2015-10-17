class VolumeChartController < ApplicationController
  require 'rest-client'
  require 'json'
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

    @labels = Array.new
    @values = Array.new

    @result_json.each do |val|
      puts val
      @labels.insert(0,val[0])
      @values.insert(0,val[5])
    end

    return @labels, @values
  end
end
