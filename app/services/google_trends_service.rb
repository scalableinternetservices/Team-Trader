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
        'NID'=>nid.sample
      }
    end
    
    def nid
      [
        '72=dOq_sKa79YxKWqSsNtqkpSD4OzuljNH1L79xfwN-BVS4Av-HlE9guDkRlfsBe2t2Ooiby3mNCjie0JdZxnWNcPs8v2eW0qRnXofJvNCajJ2sSiTvLFVMWQSAahbgXbmJ',
        '74=FzM5QkbxG76Vj8JIxAfNTDOKkdJ696-25jJiWS2DxO7jLK1PGrSnrc4dzPqE8BDO1o5y2_tClIm16xi-EisSM11Dy3gpipXd63qTiUq-y37A763XIuI3f9cgt9fpx0_31Us8flq-C_RY1mkn0lByT7VOweyKFfj6rQbraeX7pmIkh71TKw0BqJnPsqYcvH9KRh1c',
        '74=aEbh5-sgUfDcdId0QS0yajdi09Xds1WNiltLZFtlDDm5jwo7NXjHPE6oLW_nNGLDLtfYkqoJlVAnE8RLHbo30ivVTcQkjnLfOFeDyJR5Th8jaRnWcB_EhFfd6R8NdMexxSiMXrFQvA2ECMoI8jXc66CmvIe7SjWl4QG-4ayPmpc_AzoHt7oi46-IOpTKlu6zGJkfQg'
      ]
    end
    
    def get_data(url)
      puts url
      Rails.cache.fetch(url, :expires =>12.hours) do
        response = RestClient.get(url, {'Cache-Control' => 'max-age=0', :cookies=>cook })
        GoogleTrendsParser.parse(response)
      end
    end

  end
end
