class QuotesController < ApplicationController
  require 'net/http'
  def getHistoricalData()
url =URI.parse('https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.historicaldata%20where%20symbol%20%3D%20%22YHOO%22%20and%20startDate%20%3D%20%222014-02-11%22%20and%20endDate%20%3D%20%222015-02-18%22&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=')
req=Net::HTTP::Get.new(url.path)
res=Net::HTTP.start(url.host,url.port){|http|http.request(req)}
@output = res.body
  end
end
