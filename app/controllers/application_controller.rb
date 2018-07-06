class ApplicationController < ActionController::Base
  require 'rest-client'

  def call_api(url)
    response = RestClient::Request.execute(
        method: :get,
        url: url,
        headers: {'Content-Type': 'application/json'}
    )
    JSON.parse(response)
  end
end
