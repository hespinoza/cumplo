class IndicatorController < ApplicationController
  require 'date'

  def index
  end

  def get_indicator
    from = params[:indicator][:from] == '' ? Date.today : Date.parse(params[:indicator][:from])
    to = params[:indicator][:to] == '' ? Date.today : Date.parse(params[:indicator][:to])
    array_name = params[:indicator][:type] == 'uf' ? 'UFs' : 'Dolares'
    sum = 0.0
    selected_values = []

    data = call_api(params[:indicator][:type], from.year, from.month, to.year, to.month, array_name)

    array_data = data.map{|x| [x['Fecha'],x['Valor']]}
    @maped_data = array_data.map {|date,value| [date,(value.delete('.').split(',').join('.').to_f)] if Date.parse(date) >= from && Date.parse(date) <= to}.compact

    @maped_data.each do |date,value|
      sum += value
      selected_values << value
    end

    @average = (sum / @maped_data.count).round(2)
    @max_value = selected_values.max
    @min_value = selected_values.min
    @from_value = params[:indicator][:from] == '' ? Date.today.to_s : params[:indicator][:from]
    @to_value = params[:indicator][:to] == '' ? Date.today.to_s : params[:indicator][:to]
    @indicator_value = params[:indicator][:type] == '' ? 'uf' : params[:indicator][:type]

    render :template => "indicator/index"
  end
end
