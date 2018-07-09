class IndicatorController < ApplicationController
  require 'date'

  def index
  end

  def get_uf
    from = params[:uf][:from] == '' ? Date.today : Date.parse(params[:uf][:from])
    to = params[:uf][:to] == '' ? Date.today : Date.parse(params[:uf][:to])
    array_name = params[:uf][:indicator] == 'uf' ? 'UFs' : 'Dolares'

    data = call_api("https://api.sbif.cl/api-sbifv3/recursos_api/#{params[:uf][:indicator]}/periodo/#{from.year}/#{from.month}/#{to.year}/#{to.month}")[array_name]

    array_data = data.map{|x| [x['Fecha'],x['Valor']]}
    @final_data = array_data.map {|date,value| [date,(value.delete('.').split(',').join('.').to_f)] if Date.parse(date) >= from && Date.parse(date) <= to}.compact
    sum = 0.0
    selected_values = []

    @final_data.each do |date,value|
      sum += value
      selected_values << value
    end

    @average = (sum / @final_data.count).round(2)
    @max_value = selected_values.max
    @min_value = selected_values.min
    @from_value = params[:uf][:from] == '' ? Date.today.to_s : params[:uf][:from]
    @to_value = params[:uf][:to] == '' ? Date.today.to_s : params[:uf][:to]
    @indicator_value = params[:uf][:indicator] == '' ? 'uf' : params[:uf][:indicator]

    render :template => "indicator/index"
  end
end
