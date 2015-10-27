class APIError < StandardError
end

class GoogleTrendsService
  class <<self
    def getDaily(term)
      getMonths(term, 3)
    end

    def getWeekly(term)
      get(term, 36)
    end

    def getMonths(term, months)
      get(term, 'today+'+months.to_s+'-m')
    end

    private

    def get(term, date)
      request = create_request(term, date)
      get_data(request)
    end
    
    def create_request(term, date)
      action_url + common_params + '&q=' + term + '&date=' + date
    end

    def action_url
      'http://www.google.com/trends/fetchComponent'
    end

    def common_params
      '?cid=TIMESERIES_GRAPH_0&export=3&geo=US'
    end

    def cook
      {
        'NID'=>'72=dOq_sKa79YxKWqSsNtqkpSD4OzuljNH1L79xfwN-BVS4Av-HlE9guDkRlfsBe2t2Ooiby3mNCjie0JdZxnWNcPs8v2eW0qRnXofJvNCajJ2sSiTvLFVMWQSAahbgXbmJ'
      }
    end

    def get_data(url)
      Rails.cache.fetch(url, :expires =>12.hours) do
        response = RestClient.get(url, {'Cache-Control' => 'max-age=0', :cookies=>cook })
        GoogleTrendsParser.parse(response)
      end
    end

  end
end
