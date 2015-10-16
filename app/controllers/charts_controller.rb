class ChartsController < ApplicationController
  require 'rest-client'
  require 'json'
  # def configure(apiKey = '5zyrUn8zyFNM3Zqb11A1')
  #   Quandl::ApiConfig.api_key = apiKey
  #   Quandl::ApiConfig.api_version = '2015-04-09'
  # end

  def PLChart
    # configure
    start_date = params[:start_date]
    end_date = params[:end_date]
    url = "https://www.quandl.com/api/v3/datasets/BCB/UDJIAD1.json"
    params = {:params => {'start_date'=> start_date, 'end_date'=> end_date}}
    fresh_when([params])
    result = RestClient.get(url,params)
    @result_json = JSON.parse(result)
    @result_json = @result_json['dataset']['data']

    @labels = Array.new
    @values = Array.new

    @result_json.each do |val|
      @labels.insert(0,val[0])
      @values.insert(0,val[1])
    end

    return @labels, @values
  end
end
