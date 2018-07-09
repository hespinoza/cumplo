Rails.application.routes.draw do
  root 'indicator#index'
  resources :indicator
  resources :tmc
  post 'indicator/get_uf'
  post 'tmc/get_tmc'
end
