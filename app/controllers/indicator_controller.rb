class IndicatorController < ApplicationController
  def index
    @data = call_api('https://api.sbif.cl/api-sbifv3/recursos_api/uf/periodo/2010/01/2010/03')
  end
end
