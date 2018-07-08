Rails.application.routes.draw do
  resources :indicator
  post 'indicator/get_uf'
  #get 'indicator/index'
end
