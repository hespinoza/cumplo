class IndicatorController < ApplicationController
  require 'date'

  def index

  end

  def get_uf
    from = (params[:uf][:from].to_s.split('-'))
    to = (params[:uf][:to].to_s.split('-'))
    from_date = params[:uf][:from] == '' ? Date.today : Date.parse(params[:uf][:from])
    to_date = params[:uf][:to] == '' ? Date.today : Date.parse(params[:uf][:to])

    data = call_api("https://api.sbif.cl/api-sbifv3/recursos_api/uf/periodo/#{from[0]}/#{from[1]}/#{to[0]}/#{to[1]}")['UFs']

    array_data = data.map{|x| [x['Fecha'],x['Valor']]}
    @final_data = array_data.map {|date,value| [date,(value.delete('.').split(',').join('.').to_f)] if Date.parse(date) >= from_date && Date.parse(date) <= to_date}.compact
    sum = 0.0
    selected_values = []

    @final_data.each do |date,value|
      num_value = value
      sum += num_value
      selected_values << num_value
    end

    @average = (sum / @final_data.count).round(2)
    @max_value = selected_values.max
    @min_value = selected_values.min
    @from_value = params[:uf][:from] == '' ? Date.today.to_s : params[:uf][:from]
    @to_value = params[:uf][:to] == '' ? Date.today.to_s : params[:uf][:to]

    render :template => "indicator/index"
  end
end
