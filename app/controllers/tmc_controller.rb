class TmcController < ApplicationController
  require 'date'

  def index
  end

  def get_tmc
    from = params[:tmc][:from] == '' ? Date.today : Date.parse(params[:tmc][:from])
    to = params[:tmc][:to] == '' ? Date.today : Date.parse(params[:tmc][:to])

    data = call_api('tmc', from.year, from.month, to.year, to.month, 'TMCs')

    array_data = data.map{|x| [x['Fecha'],x['Valor'],x['Tipo']]}
    @maped_data = array_data.map {|date,value,type| [date,(value.to_f),type] if Date.parse(date) >= from && Date.parse(date) <= to}.compact

    @chart_data = (data.group_by{ |x| x['Tipo'] }).map{|v,y| {name: v, data: y.map{|z| {z['Fecha'] => z['Valor']}}.reduce(&:merge)} }

    @from_value = params[:tmc][:from] == '' ? Date.today.to_s : params[:tmc][:from]
    @to_value = params[:tmc][:to] == '' ? Date.today.to_s : params[:tmc][:to]

    render :template => "tmc/index"
  end
end
