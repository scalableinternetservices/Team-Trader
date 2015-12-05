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
        '74=q_CY4jEIHGkS9jfL9IQND_2LgDMRgGpNpyTl3Jb_lTDBgyA0hX-J1_U75-4AX81iLh4OA_XR2W_J1jeQ31U6Vu6J0Ph3w6CDcU7ZanRZywKVICSFOdgCs9UC4G5v3QhDdw8cVYFFkPO3wr6vVB5YrBwqlTO7izuGM3o4vI1tsdrDKt6qBrk2RPGeBBTfa5Cjmi1VGg',
        '74=y9aanhNF_8csqeQ51De0ekLMTwa3ktHCGT_Nxk6orMFsbOEFQi6zy7mm0hMYBnD8hJ2j_TDongAOBJ4JCx8Nj_Ca-sTczDMOk4Mn40IUPDWAn2te1ZNoy8WF8AHt4Gh3QHygim78PEI6oe6vjvsxRoxEFzhSWdQcz5VTxEkIyIDj7LQ5cmIAqAl3u4kbPX6tJA',
        '74=vH4asjPxWW5xBfQFH-WEyprchodWGSF5TFs5TvC0J7Glmx6yjQPAWYs-UlpxLpCxqX_hFxZlIPOZn0DpvzE3wcElPccGahrHANhd-28H-tt6r-0zKgPPRCPigA0G66k97Drv-2g0BE69LRrdnsaI2FZZgk-Ef-wLKd1vI_iNUcAVgNevgKOJpbkCRBMJG0ePU70',
        '74=q94pd6oEBJ6Pg0bZjj5ndHC5luuqnaFnsqlSetRUavS8hQ4qPoXMjPHMZ__qv1v6TPTW-Mc2yRHbFVI72Br6DFf_4eV7u4MoodZxfBp84unCJBZmqCfd5VE6ouwmY6fYRwVE7-Oa8ZuHZGga0pTY6KbDV8adWCW-NI8yMiOJ5CViRs-ltSl216MmmRPvVaDY-vI'
      ]
    end
    
    def get_data(url)
      Rails.cache.fetch(url, :expires_in =>12.hours) do
        response = RestClient.get(url, {'Cache-Control' => 'max-age=0', :cookies=>cook })
        GoogleTrendsParser.parse(response)
      end
    end

  end
end
