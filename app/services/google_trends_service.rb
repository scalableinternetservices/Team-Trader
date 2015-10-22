require 'rest-client'

class APIError < StandardError
end

class GoogleTrendsService
  class <<self
    def getDaily(term)
      get(term, 'today+3-m')
    end

    def getWeekly(term)
      get(term, 'today+36-m')
    end

    private

    def get(term, date)
      request = url + common_params + '&q=' + term + '&date=' + date
      response = RestClient.get(request, {'Cache-Control' => 'max-age=0' })
      raise APIError unless response.code == 200
      GoogleTrendsParser.parse(response)
    end

    def url
      'http://www.google.com/trends/fetchComponent'
    end

    def common_params
      '?cid=TIMESERIES_GRAPH_0&export=3&geo=US'
    end
  end

end
