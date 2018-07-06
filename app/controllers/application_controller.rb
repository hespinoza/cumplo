class ApplicationController < ActionController::Base
  require 'rest-client'

  def call_api(url)
    params = { apikey: '75f944f4c8c39a1d5967d40d8b4adc35a5bca11a', formato: 'json'}
    response = RestClient.get(url, params: params)

    if response.code === 200
      data = JSON.parse(response)
    else
      puts response.body
      data = 'Error'
    end
    data
  end
end
