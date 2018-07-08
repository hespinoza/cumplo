class IndicatorController < ApplicationController
  require 'date'

  def index

  end

  def get_uf
    from = (params[:uf][:from].to_s.split('-'))
    to = (params[:uf][:to].to_s.split('-'))
    from_date = Date.parse(params[:uf][:from])
    to_date = Date.parse(params[:uf][:to])

    data = call_api("https://api.sbif.cl/api-sbifv3/recursos_api/uf/periodo/#{from[0]}/#{from[1]}/#{to[0]}/#{to[1]}")['UFs']
    array_data = data.map{|x| [x['Fecha'],x['Valor']]}
    @final_data = array_data.map {|date,value| [date,value] if Date.parse(date) >= from_date && Date.parse(date) <= to_date}.compact
    sum = 0.0

    @final_data.each do |date,value|
      sum += value.delete('.').split(',').join('.').to_f
    end
    @prom = (sum / @final_data.count).round(2)

    render :template => "indicator/index"
  end
end
