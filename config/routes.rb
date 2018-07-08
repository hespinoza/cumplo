Rails.application.routes.draw do
  root 'indicator#index'

  resources :indicator
  post 'indicator/get_uf'
  #get 'indicator/index'
end
