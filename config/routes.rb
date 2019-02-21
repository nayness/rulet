Rails.application.routes.draw do
  resources :players
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'rounds#table'
  get '/table', to: 'rounds#table'
  post '/gamble', to: 'rounds#create'
  get '/infinite_rounds', to: 'rounds#infinite_rounds'
end
