class ApplicationController < ActionController::Base
  require 'rest-client'

  def call_api(indicator, from_year, from_month, to_year, to_month, data_index)
    params = { apikey: '75f944f4c8c39a1d5967d40d8b4adc35a5bca11a', formato: 'json'}
    url = "https://api.sbif.cl/api-sbifv3/recursos_api/#{indicator}/periodo/#{from_year}/#{from_month}/#{to_year}/#{to_month}"
    response = RestClient.get(url, params: params)

    if response.code === 200
      data = JSON.parse(response)
    else
      puts response.body
      data = 'Error'
    end
    data[data_index]
  end
end
